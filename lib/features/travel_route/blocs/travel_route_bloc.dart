import 'package:flutter_animation/base/blocs/base_bloc.dart';
import 'package:flutter_animation/base/blocs/base_state.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/travel_route/event/travel_route_event.dart';
import 'package:flutter_animation/features/travel_route/repos/travel_route_repository.dart';

import '../../../injector.dart';
import '../../../models/user_info_initial_argument.dart';
import '../../../route/page_routes.dart';
import '../models/travle_route.dart';

class TravelRouteBloc extends BaseBloc<TravelRouteEvent, BaseState> {
  final TravelRouteRepository _repository = it<TravelRouteRepository>();

  Stream<List<TravelRoute>> get routes => _repository.getAll;

  TravelRouteBloc() : super(const BaseState()) {
    on<OnAddNewRoute>((event, emit) async {
      await UtilsHelper.runWithLoadingDialog(
        func: () async {
          emit(const BaseState(isLoading: true));
          await _repository.create(event.route);
          emit(const BaseState(isLoading: false));
        },
        onFailed: (e) {
          emit(const BaseState(isLoading: false));
        },
      );
    });
  }
}
