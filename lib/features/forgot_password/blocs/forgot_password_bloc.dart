import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/repos/user_repository.dart';

import '../../../base/blocs/base_bloc.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../injector.dart';
import '../event/forgot_password_event.dart';
import '../states/forgot_password_state.dart';

class ForgotPasswordBloc extends BaseBloc<ForgotPasswordEvent, ForgotPasswordState> {
  final UserRepository _userRepository = it<UserRepository>();

  ForgotPasswordBloc() : super(ForgotPasswordState.init()) {
    on<OnForgotPasswordPress>((event, emit) async {
      await UtilsHelper.runWithLoadingDialog(
        func: () async {
          emit(state.copyWith(isLoading: true));

          if (event.email.isEmpty) throw 'Email cannot be empty!';

          await _userRepository.sendResetCode(event.email);
          DialogUtils.showToast('The reset password has been sent to your email');
          emit(state.copyWith(isLoading: false));

          UtilsHelper.popToLogin();
        },
        onFailed: (e) {
          emit(state.copyWith(isLoading: false));
        },
      );
    });
  }
}
