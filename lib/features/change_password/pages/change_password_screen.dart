import 'package:flutter/material.dart';
import 'package:flutter_animation/base/blocs/base_state.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';
import 'package:flutter_animation/widgets/staless/bounce_scroll.dart';
import 'package:flutter_animation/widgets/staless/primary_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/src/app_colors.dart';
import '../../../core/utils/dimension.dart';
import '../../../core/utils/utils_helper.dart';
import '../../../widgets/staless/base_tab_widget.dart';
import '../../../widgets/staless/loading_button.dart';
import '../../../widgets/staless/spacer.dart';
import '../../../widgets/stateful/text_input.dart';
import '../blocs/change_password_cubit.dart';

class ChangePasswordScreen extends StatefulWidget{
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  late final ChangePasswordCubit _changePasswordCubit;

  final String h1 = 'Change Password';
  final String h2 = 'Please enter your password and new password!';
  final String passwordLabel = 'Password';
  final String passwordHint = 'Email';
  final String newPasswordHint = 'New password';
  final String confirmPasswordHint = 'Confirm password';
  final String changePassLabel = 'Change Password';

  @override
  void initState() {
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _changePasswordCubit = ChangePasswordCubit();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paddingSize = DeviceDimension.screenWidth * 0.05;
    final ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (_) => _changePasswordCubit,
      child: OriginScreen(
        appbar: const PrimaryAppBar(),
        child: BounceScroll(
          child: SizedBox(
            width: double.infinity,
            height: DeviceDimension.screenHeight * 0.85,
            child: Padding(
              padding: EdgeInsets.all(paddingSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(h1, style: theme.textTheme.headlineSmall),
                            const SpaceHorizontal(width: 10),
                            const Icon(Icons.person_outline_rounded),
                          ],
                        ),
                        const SpaceVertical(height: 10),
                        Text(h2, style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  Text(passwordLabel, style: theme.textTheme.headlineLarge),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SpaceVertical(height: DeviceDimension.padding / 2),
                      TextInput(controller: _newPasswordController, hint: newPasswordHint, borderWidth: 0.5, label: newPasswordHint, secureText: true, imageBack: Assets.eyeIcon),
                      SpaceVertical(height: DeviceDimension.padding / 2),
                      TextInput(controller: _confirmPasswordController, hint: confirmPasswordHint, borderWidth: 0.5, label: confirmPasswordHint, secureText: true, imageBack: Assets.eyeIcon),
                      SpaceVertical(height: DeviceDimension.padding),
                    ],
                  ),
                  BlocBuilder<ChangePasswordCubit, BaseState>(
                    builder: (context, state) => LoadingButton(
                      label: changePassLabel,
                      onPress: _onChangePasswordPress,
                      isLoading: state.isLoading,
                    ),
                  ),
                  const SpaceVertical(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onChangePasswordPress() {
    _changePasswordCubit.changePassword(newPass: _newPasswordController.text, confirmPass: _confirmPasswordController.text);
  }
}