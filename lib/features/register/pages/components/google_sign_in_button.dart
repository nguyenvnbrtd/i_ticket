import 'package:flutter/material.dart';
import 'package:flutter_animation/widgets/staless/base_tab_widget.dart';

import '../../../../core/src/assets.dart';
import '../../../../widgets/staless/custom_icon.dart';
import '../../../../widgets/staless/spacer.dart';

class GoogleSignInButton extends StatelessWidget{
  const GoogleSignInButton({Key? key}) : super(key: key);

  void onRegisterWithGoogle() {}

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BaseTabWidget(
      onTap: onRegisterWithGoogle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomIcon(size: 25, icon: Assets.googleIcon),
          const SpaceHorizontal(width: 10),
          Text('Google', style: theme.textTheme.headlineSmall?.copyWith(fontSize: 18)),
        ],
      ),
    );
  }
}