import 'package:flutter_animation/base/cubits/base_cubit.dart';
import 'package:flutter_animation/features/booking/models/booking_detail.dart';
import 'package:flutter_animation/features/booking/repos/booking_route_repository.dart';
import 'package:flutter_animation/features/user_info/repos/user_info_repository.dart';

import '../../../base/blocs/base_state.dart';
import '../../../injector.dart';

class HistoryCubit extends BaseCubit<BaseState> {
  final BookingRouteRepository _repository = it<BookingRouteRepository>();
  final UserInfoRepository _userInfoRepository = it<UserInfoRepository>();

  Stream<List<BookingDetail>> routes() {
    final uid = _userInfoRepository.userInfo?.id ?? '';
    return _repository.getAllWithUserId(uid);
  }

  HistoryCubit() : super(const BaseState(isLoading: false));

}
