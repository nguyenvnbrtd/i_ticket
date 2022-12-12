import 'package:flutter_animation/base/blocs/base_bloc.dart';
import 'package:flutter_animation/core/utils/dialog_utils.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/travel_route/event/travel_route_event.dart';
import 'package:flutter_animation/features/travel_route/repos/travel_route_repository.dart';

import '../../../injector.dart';
import '../models/travle_route.dart';
import '../states/travel_route_state.dart';

class TravelRouteBloc extends BaseBloc<TravelRouteEvent, TravelRouteState> {
  final TravelRouteRepository _repository = it<TravelRouteRepository>();

  Stream<List<TravelRoute>> get routes => _repository.getAll;

  TravelRouteBloc() : super(TravelRouteState.init()) {
    on<OnInitRoute>((event, emit) async {
      await UtilsHelper.runInGuardZone(
        func: () async {
          emit(state.copyWith(isInitData: true));
          final data = await _repository.getById(event.id);
          emit(state.copyWith(isInitData: false, route: state.route.copyWith(data: data)));
        },
        onFailed: (e) {
          emit(state.copyWith(isLoading: false));
        },
      );
    });

    on<OnAddNewRoute>((event, emit) async {
      await UtilsHelper.runInGuardZone(
        func: () async {
          if((event.route.name ?? '').isEmpty){
            throw 'Please enter route name!';
          }
          if((event.route.departureName ?? '').isEmpty){
            throw 'Please enter departure place!';
          }
          if((event.route.destinationName ?? '').isEmpty){
            throw 'Please enter destination place!';
          }
          if((event.route.licensePlate ?? '').isEmpty){
            throw 'Please enter license plate!';
          }
          if((event.route.distance ?? '').isEmpty){
            throw 'Please enter the estimate distance!';
          }
          if((event.route.price ?? 0) == 0){
            throw 'Please enter price for 1 ticket!';
          }
          if((state.route.departureTime ?? '').isEmpty){
            throw 'Please enter departure time!';
          }
          if((state.route.destinationTime ?? '').isEmpty){
            throw 'Please enter destination time!';
          }

          emit(state.copyWith(isLoading: true));
          await _repository.create(state.route.copyWith(data: event.route));
          emit(state.copyWith(isLoading: false));
          DialogUtils.showToast('Add success!');
          UtilsHelper.pop();
        },
        onFailed: (e) {
          emit(state.copyWith(isLoading: false));
        },
      );
    });

    on<OnUpdateRoute>((event, emit) async {
      await UtilsHelper.runInGuardZone(
        func: () async {
          emit(state.copyWith(isLoading: true));
          await _repository.update(id: event.id, data: state.route.copyWith(data: event.route));
          DialogUtils.showToast('Update success!');
          emit(state.copyWith(isLoading: false));
        },
        onFailed: (e) {
          emit(state.copyWith(isLoading: false));
        },
      );
    });

    on<OnDeleteRoute>((event, emit) async {
      await UtilsHelper.runInGuardZone(
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
      emit(state.copyWith(route: TravelRoute(departureTime: UtilsHelper.formatTime(event.time))));
    },);
    on<OnChangeDestinationTime>((event, emit) async {
      emit(state.copyWith(route: TravelRoute(destinationTime: UtilsHelper.formatTime(event.time))));
    },);
    on<OnChangeButtonLabel>((event, emit) async {
      emit(state.copyWith(buttonLabel: event.label));
    },);
  }
}
