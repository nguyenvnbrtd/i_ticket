import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/repos/user_repository.dart';

import '../../../base/blocs/base_bloc.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../injector.dart';
import '../event/login_event.dart';
import '../states/login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  final UserRepository _userRepository = it<UserRepository>();

  LoginBloc() : super(LoginState.init()) {
    on<OnLoginPress>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      await _userRepository.logIn(event.useName, event.password).then((UserCredential? value) {
        if(value == null){
          throw 'Cannot login';
        }

        if(value.user == null){
          throw 'Cannot login';
        }

        emit(state.copyWith(isLoading: false));

        UtilsHelper.login(value.user!.uid);
      }).onError((error, stackTrace) {
        emit(state.copyWith(isLoading: false));

        if (error is FirebaseException) {
          DialogUtils.showToast(error.message ?? error.toString());
          return;
        }
        DialogUtils.showToast(error.toString());
      });

    });
  }
}
