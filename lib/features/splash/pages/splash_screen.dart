import 'package:flutter/material.dart';
import 'package:flutter_animation/core/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_animation/core/blocs/authentication/authentication_event.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/splash_screen_bloc.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 500));
      context.read<AuthenticationBloc>().add(OnStartAuthentication());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashScreenBloc(),
      child: OriginScreen(
        child: Image.asset(Assets.splashImage, fit: BoxFit.contain),
      ),
    );
  }
}
