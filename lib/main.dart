import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/core/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_animation/core/blocs/authentication/authentication_state.dart';
import 'package:flutter_animation/core/utils/log_utils.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/splash/pages/splash_screen.dart';
import 'package:flutter_animation/repos/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/src/app_colors.dart';
import 'core/src/app_theme.dart';
import 'core/utils/dimension.dart';
import 'features/user_info/repos/user_info_repository.dart';
import 'firebase_options.dart';
import 'injector.dart';
import 'route/page_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();

  // runZonedGuarded(
    // () {
      runApp(const MyApp());
    // },
    // (error, stack) {
    //   LogUtils.e(message: error.toString());
    // },
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc(),
        ),
      ],
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: _authenticationListener,
        child: GestureDetector(
          onTap: UtilsHelper.dismissKeyBoard,
          child: Container(
            color: AppColors.white,
            child: MaterialApp(
              navigatorKey: UtilsHelper.navigatorKey,
              color: AppColors.white,
              title: 'I-Ticket',
              theme: AppTheme.defaultTheme,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: Routes.generateRoute,
              home: Builder(
                builder: (context) {
                  DeviceDimension().initValue(context);

                  return const SplashScreen();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _authenticationListener(BuildContext context, state) async {
    if (state is AuthenticationStateLoggedIn) {
      final userInfoRepository = it<UserInfoRepository>();
      await userInfoRepository.getById(state.id);
      UtilsHelper.popAllAndPushNamed(Routes.main);
      return;
    }

    if (state is AuthenticationStateNotLoggedIn) {
      await it<UserRepository>().logOut();
      UtilsHelper.popAllAndPushNamed(Routes.login);
      return;
    }
  }
}
