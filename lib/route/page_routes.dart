import 'package:flutter/material.dart';
import 'package:flutter_animation/features/forgot_password/pages/forgot_password_screen.dart';
import 'package:flutter_animation/features/home/pages/home_screen.dart';
import 'package:flutter_animation/features/login/pages/login_screen.dart';
import 'package:flutter_animation/features/main/pages/main_screen.dart';
import 'package:flutter_animation/features/payment/pages/payment_screen.dart';
import 'package:flutter_animation/features/travel_route/models/travle_route.dart';
import 'package:flutter_animation/features/user_info/pages/user_info_initial_screen.dart';
import 'package:flutter_animation/models/user_info_initial_argument.dart';

import '../features/booking/blocs/booking_cubit.dart';
import '../features/register/pages/register_screen.dart';
import '../features/splash/pages/splash_screen.dart';
import '../features/travel_route/pages/add_travel_route_screen.dart';
import '../features/user_info/pages/user_info_screen.dart';
import '../features/user_info/pages/user_info_update.dart';
import '../models/arguments_screen_model.dart';
import '../models/payment_argument.dart';
import '../models/travel_route_argument.dart';

class Routes {

  Routes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot_pass';
  static const String main = '/main';
  static const String home = '/home';
  static const String userInfo = '/user_info';
  static const String userInfoUpdate = '/user_info_update';
  static const String userInfoInitial = '/user_info_initial';
  static const String addTravelRoute = '/add_travel_route';
  static const String payment = '/payment';

  static String _current = splash;

  static get current => _current;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    _current = settings.name ?? splash;

    final arguments = settings.arguments != null && settings.arguments is ArgumentsScreenModel
        ? settings.arguments as ArgumentsScreenModel
        : ArgumentsScreenModel(title: "unknowns");

    switch (settings.name) {
      case splash:
        return SlideRightRoute(
          routeSettings: const RouteSettings(name: splash),
          widget: const SplashScreen(),
        );
      case login:
        return SlideRightRoute(
          routeSettings: const RouteSettings(name: login),
          widget: const LoginScreen(),
        );
      case register:
        return SlideRightRoute(
          routeSettings: const RouteSettings(name: register),
          widget: const RegisterScreen(),
        );
      case forgotPassword:
        return SlideRightRoute(
          routeSettings: const RouteSettings(name: forgotPassword),
          widget: const ForgotPasswordScreen(),
        );
      case main:
        return SlideRightRoute(
          routeSettings: const RouteSettings(name: main),
          widget: const MainScreen(),
        );
      case home:
        return SlideRightRoute(
          routeSettings: const RouteSettings(name: home),
          widget: const HomeScreen(),
        );
      case userInfo:
        return SlideRightRoute(
          routeSettings: const RouteSettings(name: userInfo),
          widget: const UserInfoScreen(),
        );
      case userInfoInitial:
        final arg = arguments.data as UserInfoInitialArgument;
        return SlideRightRoute(
          routeSettings: const RouteSettings(name: userInfoInitial),
          widget: UserInfoInitialScreen(uid: arg.uid, email: arg.email),
        );
      case userInfoUpdate:
        return SlideRightRoute(
          routeSettings: const RouteSettings(name: userInfoUpdate),
          widget: const UserInfoUpdate(),
        );
      case addTravelRoute:
        final arg = (arguments.data != null) ? arguments.data as TravelRouteArgument : TravelRouteArgument('');
        return SlideRightRoute(
          routeSettings: const RouteSettings(name: addTravelRoute),
          widget: AddTravelRouteScreen(id: arg.id),
        );
      case payment:
        final arg = (arguments.data != null) ? arguments.data as PaymentArgument : PaymentArgument(BookingCubit(TravelRoute()));

        return SlideRightRoute(
          routeSettings: const RouteSettings(name: payment),
          widget: PaymentScreen(bookingCubit: arg.bookingCubit),
        );

      default:
        return MaterialPageRoute(settings: const RouteSettings(name: splash), builder: (_) => const SplashScreen());
    }
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings? routeSettings;
  final bool reverse;

  SlideRightRoute({required this.widget, this.routeSettings, this.reverse = false})
      : super(
          settings: routeSettings,
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(reverse ? -1.0 : 1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
