import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';
import 'package:flutter_animation/widgets/staless/loading_button.dart';
import 'package:flutter_animation/widgets/staless/spacer.dart';
import 'package:flutter_animation/widgets/stateful/text_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../route/page_routes.dart';
import '../../../widgets/staless/base_tab_widget.dart';
import '../blocs/forgot_password_bloc.dart';
import '../event/forgot_password_event.dart';
import '../states/forgot_password_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  late final TextEditingController _emailController;
  late final ForgotPasswordBloc _forgotPasswordBloc;

  final String h1 = 'Reset Password';
  final String h2 = 'Please enter your email!';
  final String h3 = 'Email';
  final String hint1 = 'Email';
  final String resetLabel = 'Send';
  final String goBackTo = 'Go back to ';
  final String loginLabel = 'Login';
  final String contactDeveloper = 'If you can not reset password, contact the administrator';

  @override
  void initState() {
    _emailController = TextEditingController();
    _forgotPasswordBloc = ForgotPasswordBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paddingSize = DeviceDimension.screenWidth * 0.05;
    final ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (_) => _forgotPasswordBloc,
      child: OriginScreen(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(h3, style: theme.textTheme.headlineLarge),
                  SpaceVertical(height: DeviceDimension.screenHeight * 0.1),
                  TextInput(controller: _emailController, hint: hint1, borderWidth: 0.5),
                  const SpaceVertical(height: 10),
                  BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                    builder: (context, state) => LoadingButton(
                      label: resetLabel,
                      onPress: _onForgotPasswordPress,
                      isLoading: state.isLoading,
                    ),
                  ),
                ],
              ),
              BaseTabWidget(
                onTap: UtilsHelper.popToLogin,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: goBackTo,
                        style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                      ),
                      TextSpan(
                        text: loginLabel,
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(),
              Text(contactDeveloper, style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  _onForgotPasswordPress() {
    UtilsHelper.dismissKeyBoard();
    _forgotPasswordBloc.add(OnForgotPasswordPress(email: _emailController.text.trim()));
  }
}
