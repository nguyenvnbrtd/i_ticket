import 'package:flutter_animation/base/cubits/base_cubit.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';

import '../../../injector.dart';
import '../models/travle_route.dart';
import '../repos/travel_route_repository.dart';
import '../states/seats_status_state.dart';

class SeatsStatusCubit extends BaseCubit<SeatsStatusState>{
  final TravelRouteRepository _repository = it<TravelRouteRepository>();

  SeatsStatusCubit() : super(SeatsStatusState.init());

  void initData({String id = '', TravelRoute? travelRoute}) async {
    if(travelRoute != null){
      emit(state.copyWith(route: travelRoute));
      return;
    }
    await UtilsHelper.runInGuardZone(func: () async {
      emit(state.copyWith(isLoading: true));
      final data = await _repository.getById(id);
      emit(state.copyWith(isLoading: false, route: data));
    }, onFailed: (e) {
      emit(state.copyWith(isLoading: false));
    },);
  }
}