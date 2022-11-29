import 'package:flutter_animation/base/blocs/base_state.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/user_info/event/user_info_event.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../base/blocs/base_bloc.dart';
import '../../../injector.dart';
import '../repos/user_info_repository.dart';

class UserInfoBloc extends BaseBloc<UserInfoEvent, BaseState> {
  UserInfoRepository repository = it();

  UserInfoBloc() : super(const BaseState()) {
    on<OnInitData>((event, emit) async {
      await repository.createUserData(event.userInfo);
    });

    on<OnSavePress>(
      (event, emit) async {
        await UtilsHelper.runWithLoadingDialog(
          func: () async {
            emit(const BaseState(isLoading: true));
            await repository.updateUserData(userInfo: event.userInfo);
            emit(const BaseState(isLoading: false));
            Fluttertoast.showToast(msg: 'Save data success');
          },
          onFailed: (e) {
            emit(const BaseState(isLoading: false));
          },
          showLoading: false,
        );
      },
    );
  }
}
