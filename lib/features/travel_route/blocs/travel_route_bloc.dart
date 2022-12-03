import 'package:flutter_animation/base/blocs/base_bloc.dart';
import 'package:flutter_animation/base/blocs/base_state.dart';
import 'package:flutter_animation/core/utils/dialog_utils.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/travel_route/event/travel_route_event.dart';
import 'package:flutter_animation/features/travel_route/repos/travel_route_repository.dart';

import '../../../injector.dart';
import '../../../models/user_info_initial_argument.dart';
import '../../../route/page_routes.dart';
import '../models/travle_route.dart';
import '../states/travel_route_state.dart';

class TravelRouteBloc extends BaseBloc<TravelRouteEvent, TravelRouteState> {
  final TravelRouteRepository _repository = it<TravelRouteRepository>();

  Stream<List<TravelRoute>> get routes => _repository.getAll;

  TravelRouteBloc() : super(TravelRouteState.init()) {
    on<OnAddNewRoute>((event, emit) async {
      await UtilsHelper.runWithLoadingDialog(
        func: () async {
          emit(state.copyWith(isLoading: true));
          await _repository.create(event.route);
          emit(state.copyWith(isLoading: false));
        },
        onFailed: (e) {
          emit(state.copyWith(isLoading: false));
        },
      );
    });

    on<OnDeleteRoute>((event, emit) async {
      await UtilsHelper.runWithLoadingDialog(
        func: () async {
          await _repository.delete(id: event.id);
          DialogUtils.showToast('Delete route success!');
        },
        onFailed: (e) {
          DialogUtils.showToast('Cannot delete route!');
        },
      );
    },);

    on<OnChangeDepartureTime>((event, emit) async {
      emit(state.copyWith(departureTime: event.time.toString()));
    },);
    on<OnChangeDestinationTime>((event, emit) async {
      emit(state.copyWith(destinationTime: event.time.toString()));
    },);
  }
}
