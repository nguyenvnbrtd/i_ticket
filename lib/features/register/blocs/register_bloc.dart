import 'package:flutter_animation/base/blocs/base_bloc.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';

import '../../../injector.dart';
import '../../../models/user_info_initial_argument.dart';
import '../../../repos/user_repository.dart';
import '../../../route/page_routes.dart';
import '../event/register_event.dart';
import '../states/register_state.dart';

class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository = it<UserRepository>();

  RegisterBloc() : super(RegisterState.initial()) {
    on<OnRegisterPress>(
      (event, emit) async {
        await UtilsHelper.runWithLoadingDialog(
          func: () async {
            emit(state.copyWith(isLoading: true));

            if (event.email.isEmpty) throw 'Email cannot be empty!';
            if (event.password.isEmpty) throw 'Password cannot be empty!';
            if (event.confirmPassword.isEmpty) throw 'Confirm password cannot be empty!';
            if (event.password != event.confirmPassword) throw 'Password and confirm password does not match!';
            await _userRepository.signIn(event.email, event.password);
            if (!_userRepository.isLogIn()) UtilsHelper.popUntil((route) => route.settings.name == Routes.login);
            final user = await _userRepository.getUser();
            if (user == null) return;

            emit(state.copyWith(isLoading: false));

            UtilsHelper.pushNamed(Routes.userInfoInitial, UserInfoInitialArgument(user.uid, user.email ?? ''));
          },
          onFailed: (e) {
            emit(state.copyWith(isLoading: false));
          },
        );
      },
    );
  }
}
