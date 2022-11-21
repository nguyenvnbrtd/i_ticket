import 'package:flutter/material.dart';
import 'package:flutter_animation/features/home/pages/home_screen.dart';
import 'package:flutter_animation/features/login/pages/login_screen.dart';

import '../features/register/pages/register_screen.dart';
import '../features/splash/pages/splash_screen.dart';

class Routes {

  Routes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static String _current = splash;

  static get current => _current;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    _current = settings.name ?? splash;

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
      case home:
        return SlideRightRoute(
          routeSettings: const RouteSettings(name: home),
          widget: const HomeScreen(),
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
