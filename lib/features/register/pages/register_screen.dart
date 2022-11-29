import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';
import 'package:flutter_animation/widgets/staless/loading_button.dart';
import 'package:flutter_animation/widgets/staless/spacer.dart';
import 'package:flutter_animation/widgets/stateful/text_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/staless/base_tab_widget.dart';
import '../blocs/register_bloc.dart';
import '../event/register_event.dart';
import '../states/register_state.dart';
import 'components/google_sign_in_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final RegisterBloc _registerBloc;

  final String h1 = 'Register Account';
  final String h3 = 'Create Account';
  final String hint1 = 'Email';
  final String hint2 = 'Full name';
  final String hint3 = 'Password';
  final String hint4 = 'Confirm password';
  final String hint5 = 'Phone number';
  final String registerLabel = 'Register';
  final String signInWith = 'Or sign up with';
  final String haveAnAccount = 'Have an Account? ';
  final String loginLabel = 'Login';

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _registerBloc = RegisterBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paddingSize = DeviceDimension.screenWidth * 0.05;
    final ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (_) => _registerBloc,
      child: OriginScreen(
        child: Padding(
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(h1, style: theme.textTheme.headlineSmall),
                    const SpaceHorizontal(width: 10),
                    const Icon(Icons.person_outline_rounded),
                  ],
                ),
              ),
              const SizedBox(),
              const SizedBox(),
              Text(h3, style: theme.textTheme.headlineLarge),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextInput(controller: _emailController, hint: hint1, borderWidth: 0.5),
                  const SpaceVertical(height: 10),
                  TextInput(
                    controller: _passwordController,
                    hint: hint3,
                    borderWidth: 0.5,
                    secureText: true,
                    imageBack: Assets.eyeIcon,
                  ),
                  const SpaceVertical(height: 10),
                  TextInput(
                    controller: _confirmPasswordController,
                    hint: hint4,
                    borderWidth: 0.5,
                    secureText: true,
                    imageBack: Assets.eyeIcon,
                  ),
                ],
              ),
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) => SizedBox(
                  width: DeviceDimension.screenWidth * 0.6,
                  child: LoadingButton(
                    label: registerLabel,
                    onPress: _onRegisterPress,
                    isLoading: state.isLoading,
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: DeviceDimension.screenWidth * 0.8, height: 0.5, color: AppColors.lightGrey),
                  Container(
                    color: theme.backgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: paddingSize / 2),
                    child: Text(signInWith, style: theme.textTheme.bodySmall?.copyWith(color: AppColors.grey)),
                  ),
                ],
              ),
              const GoogleSignInButton(),
              BaseTabWidget(
                onTap: _openLogin,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: haveAnAccount,
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
            ],
          ),
        ),
      ),
    );
  }

  _onRegisterPress() {
    UtilsHelper.dismissKeyBoard();
    _registerBloc.add(OnRegisterPress(
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    ));
  }

  void _openLogin() {
    UtilsHelper.pop();
  }
}
