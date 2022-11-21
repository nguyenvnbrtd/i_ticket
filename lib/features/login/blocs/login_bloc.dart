import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/core/utils/log_utils.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/repos/user_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../base/blocs/base_bloc.dart';
import '../../../injector.dart';
import '../event/login_event.dart';
import '../repos/login_repository.dart';
import '../state/login_state.dart';

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

        UtilsHelper.login(value.user!.uid);
      }).onError((error, stackTrace) {
        if (error is FirebaseException) {
          Fluttertoast.showToast(msg: error.message ?? error.toString());
          return;
        }
        Fluttertoast.showToast(msg: error.toString());
      });

      emit(state.copyWith(isLoading: false));
    });
  }
}
