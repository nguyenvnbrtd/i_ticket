import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/login/event/login_event.dart';
import 'package:flutter_animation/features/login/state/login_state.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';
import 'package:flutter_animation/widgets/staless/custom_icon.dart';
import 'package:flutter_animation/widgets/staless/loading_button.dart';
import 'package:flutter_animation/widgets/staless/spacer.dart';
import 'package:flutter_animation/widgets/stateful/text_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../route/page_routes.dart';
import '../../../widgets/staless/base_tab_widget.dart';
import '../../register/pages/components/google_sign_in_button.dart';
import '../blocs/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  late final LoginBloc _loginBloc;

  final String h1 = 'Login Account';
  final String h2 = 'Hello , welcome back to our account!';
  final String h3 = 'Welcome';
  final String hint1 = 'User name';
  final String hint2 = 'Password';
  final String forgotPass = 'Forgot Password ?';
  final String loginLabel = 'Login';
  final String registerLabel = 'Create Account';
  final String notHaveAccount = 'Not register yet? ';
  final String signInWith = 'Or sign in with';

  @override
  void initState() {
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _loginBloc = LoginBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paddingSize = DeviceDimension.screenWidth * 0.05;
    final ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (_) => _loginBloc,
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
              const SizedBox(),
              const SizedBox(),
              Text(h3, style: theme.textTheme.headlineLarge),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextInput(controller: _userNameController, hint: hint1, borderWidth: 0.5),
                  const SpaceVertical(height: 10),
                  TextInput(
                    controller: _passwordController,
                    hint: hint2,
                    borderWidth: 0.5,
                    secureText: true,
                    imageBack: Assets.eyeIcon,
                  ),
                  const SpaceVertical(height: 10),
                  Text(forgotPass, style: theme.textTheme.bodySmall?.copyWith(color: AppColors.blue600))
                ],
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) => LoadingButton(
                  label: loginLabel,
                  minWidth: DeviceDimension.screenWidth * 0.6,
                  onPress: _onLoginPress,
                  isLoading: state.isLoading,
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
                onTap: _openRegister,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: notHaveAccount,
                        style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                      ),
                      TextSpan(
                        text: registerLabel,
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

  _onLoginPress() {
    UtilsHelper.dismissKeyBoard();
    _loginBloc.add(OnLoginPress(useName: _userNameController.text, password: _passwordController.text));
  }

  void _openRegister() {
    UtilsHelper.pushNamed(Routes.register);
  }
}
