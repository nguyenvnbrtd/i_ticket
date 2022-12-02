import 'package:flutter_animation/base/blocs/base_state.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/user_info/event/user_info_event.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../base/blocs/base_bloc.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../injector.dart';
import '../repos/user_info_repository.dart';
import '../states/user_info_state.dart';

class UserInfoBloc extends BaseBloc<UserInfoEvent, UserInfoState> {
  UserInfoRepository repository = it();

  UserInfoBloc() : super(UserInfoState.init()) {
    on<OnInitData>((event, emit) async {
      await repository.create(event.userInfo);
    });

    on<OnSavePress>(
      (event, emit) async {
        await UtilsHelper.runWithLoadingDialog(
          func: () async {
            emit(state.copyWith(isLoading: true));
            await repository.updateUser(data: event.userInfo);
            emit(state.copyWith(isLoading: false, isInfoChanged: false));
            DialogUtils.showToast('Save data success');
          },
          onFailed: (e) {
            emit(state.copyWith(isLoading: false));
          },
          showLoading: false,
        );
      },
    );

    on<OnInfoChanged>(
      (event, emit) async {
        if(state.isInfoChanged == event.changed) return;
        emit(state.copyWith(isInfoChanged: event.changed));
      },
    );
  }
}
