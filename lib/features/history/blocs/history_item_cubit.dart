import 'package:flutter_animation/base/cubits/base_cubit.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/booking/repos/booking_route_repository.dart';
import 'package:flutter_animation/features/travel_route/repos/travel_route_repository.dart';
import 'package:flutter_animation/features/user_info/repos/user_info_repository.dart';

import '../../../injector.dart';
import '../states/history_item_state.dart';

class HistoryItemCubit extends BaseCubit<HistoryItemState> {
  final BookingRouteRepository _repository = it<BookingRouteRepository>();
  final TravelRouteRepository _travelRouteRepository = it<TravelRouteRepository>();
  final UserInfoRepository _userInfoRepository = it<UserInfoRepository>();

  HistoryItemCubit() : super(HistoryItemState.init());

  void initData(String routeId) async {
    await UtilsHelper.runInGuardZone(
      func: () async {
        emit(state.copyWith(isLoading: true));
        final route = await _travelRouteRepository.getById(routeId);
        emit(state.copyWith(route: route));
        emit(state.copyWith(isLoading: false));
      },
      onFailed: (e) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }
}
