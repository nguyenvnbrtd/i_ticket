import 'package:flutter_animation/base/cubits/base_cubit.dart';
import 'package:flutter_animation/core/utils/dialog_utils.dart';
import 'package:flutter_animation/core/utils/unique_id_generator.dart';
import 'package:flutter_animation/features/booking/models/booking_detail.dart';
import 'package:flutter_animation/features/travel_route/models/travle_route.dart';
import 'package:flutter_animation/features/travel_route/repos/travel_route_repository.dart';
import 'package:flutter_animation/features/user_info/repos/user_info_repository.dart';

import '../../../core/utils/utils_helper.dart';
import '../../../injector.dart';
import '../../travel_route/models/item_selected.dart';
import '../repos/booking_route_repository.dart';
import '../states/booking_state.dart';

class BookingCubit extends BaseCubit<BookingState> {
  final BookingRouteRepository _repository = it<BookingRouteRepository>();
  final UserInfoRepository _userRepository = it<UserInfoRepository>();
  final TravelRouteRepository _travelRouteRepository = it<TravelRouteRepository>();
  late final TravelRoute travelRoute;

  Stream<List<BookingDetail>> routes(String uid) => _repository.getAllWithUserId(uid);

  BookingCubit(TravelRoute route) : super(BookingState.init()){
    travelRoute = route;
  }

  void onRefreshData(List<String> data) {
    List<int> temp = List.from(state.selectedIndexs);
    temp.removeWhere((element) {
      if (data.length > element) {
        if(_userRepository.userInfo?.id != null){
          if (data[element] == _userRepository.userInfo?.id) return false;
        }
        if (data[element].isNotEmpty) return true;
      }
      return false;
    });
    emit(state.copyWith(selectedIndexs: temp));
  }

  void onItemTab(ItemSelected value) async {
    List<int> temp = List.from(state.selectedIndexs);

    if (value.isSelected) {
      if (!temp.contains(value.index)) {
        temp.add(value.index);
      }
    } else {
      temp.remove(value.index);
    }
    emit(state.copyWith(selectedIndexs: temp));
  }

  void tempTicket() async {
    await UtilsHelper.runInGuardZone(
      func: () async {
        emit(state.copyWith(isLoading: true));

        if(state.selectedIndexs.isEmpty){
          throw 'Your seats be already booked!';
        }

        List<int> temp = List.from(state.selectedIndexs);
        List<String> seats = travelRoute.seats ?? [];

        for(int i = 0; i< temp.length; i++){
          final index = temp[i];
          if(seats.length > index){
            seats[index] = _userRepository.userInfo?.id ?? '';
          }
        }

        await _travelRouteRepository.update(id: travelRoute.id ?? '', data: travelRoute.copyWith(data: TravelRoute(seats: seats)));

        emit(state.copyWith(isLoading: false));
      },
      onFailed: (e) async {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  void clearTempTicket() {
    List<int> temp = List.from(state.selectedIndexs);
    List<String> seats = travelRoute.seats ?? [];

    for(int i = 0; i< temp.length; i++){
      final index = temp[i];
      if(seats.length > index){
        seats[index] = '';
      }
    }
    _travelRouteRepository.update(id: travelRoute.id ?? '', data: travelRoute.copyWith(data: TravelRoute(seats: seats)));
  }

  void bookTicket(bool isPayed) async {
    final id = UniqueIdGenerator.uniqueId;

    await UtilsHelper.runInGuardZone(
      func: () async {
        emit(state.copyWith(isLoading: true));

        if(state.selectedIndexs.isEmpty){
          throw 'Your seats be already booked!';
        }

        await _repository.create(BookingDetail(
          id: id,
          createTime: DateTime.now().toString(),
          updateTime: DateTime.now().toString(),
          routeId: travelRoute.id,
          userId: _userRepository.userInfo?.id ?? '',
          isPayed: isPayed,
        ));

        List<int> temp = List.from(state.selectedIndexs);
        List<String> seats = travelRoute.seats ?? [];

        for(int i = 0; i< temp.length; i++){
          final index = temp[i];
          if(seats.length > index){
            seats[index] = id;
          }
        }

        await _travelRouteRepository.update(id: travelRoute.id ?? '', data: travelRoute.copyWith(data: TravelRoute(seats: seats)));

        emit(state.copyWith(isLoading: false, selectedIndexs: []));
        UtilsHelper.pop();
        DialogUtils.showToast('Book ticket success!');
      },
      onFailed: (e) async {
        await _repository.delete(id: id);
        emit(state.copyWith(isLoading: false));
      },
    );
  }
}
