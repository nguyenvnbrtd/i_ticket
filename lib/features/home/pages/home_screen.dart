import 'package:flutter/material.dart';
import 'package:flutter_animation/core/blocs/authentication/authentication_event.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/blocs/authentication/authentication_bloc.dart';
import '../../../route/page_routes.dart';
import '../../../widgets/base_screen/origin_screen.dart';
import '../../../widgets/staless/primary_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final paddingSize = DeviceDimension.screenWidth * 0.05;
    final ThemeData theme = Theme.of(context);

    return OriginScreen(
      child: Container(
        color: Colors.yellowAccent,
        child: Center(
          child: PrimaryButton(
            onPress: () {
              context.read<AuthenticationBloc>().add(AuthenticationEventLoggingOut());
            },
            label: 'Log out',
          ),
        ),
      ),
    );
  }
}
