import 'package:flutter_animation/base/blocs/base_state.dart';
import 'package:flutter_animation/base/cubits/base_cubit.dart';
import 'package:flutter_animation/core/utils/dialog_utils.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/repos/user_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../injector.dart';

class ChangePasswordCubit extends BaseCubit<BaseState> {
  final UserRepository userRepository = it();

  ChangePasswordCubit() : super(const BaseState(isLoading: false));

  void changePassword({required String newPass, required String confirmPass}) async {
    await UtilsHelper.runInGuardZone(
      func: () async {
        if(newPass.isEmpty){
          throw 'Please enter your new password';
        }

        if(confirmPass.isEmpty){
          throw 'Please enter the confirm password';
        }

        if(newPass.length < 6){
          throw 'New password at least 6 characters';
        }

        if(newPass != confirmPass){
          throw 'New password and confirmation password must match';
        }

        emit(const BaseState(isLoading: true));
        await userRepository.changePassword(newPass);
        emit(const BaseState(isLoading: false));

        DialogUtils.showToast('Change password success!');
        UtilsHelper.pop();
      },
      onFailed: (_) {
        emit(const BaseState(isLoading: false));
      },
    );
  }
}
