import 'package:flutter/material.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';

class OriginScreen extends StatefulWidget {
  final Widget? child;
  final PreferredSizeWidget? appbar;
  final Widget? bottomNavigator;
  final Future<bool> Function()? onBackPress;

  const OriginScreen({
    Key? key,
    this.child,
    this.appbar,
    this.bottomNavigator,
    this.onBackPress,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OriginScreen();
}

class _OriginScreen extends State<OriginScreen> {
  Future<bool> onBackPressed() async {
    return UtilsHelper.pop();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return WillPopScope(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: theme.backgroundColor,
            bottomNavigationBar: widget.bottomNavigator,
            appBar: widget.appbar,
            body: widget.child,
          ),
        ),
        onWillPop: widget.onBackPress ?? onBackPressed);
  }
}
