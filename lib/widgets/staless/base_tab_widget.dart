import 'package:flutter/material.dart';
import 'package:flutter_animation/core/utils/debounce.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';

class BaseTabWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? child;
  final bool dismissKeyboard;
  final bool isDelay;

  const BaseTabWidget({
    Key? key,
    this.onTap,
    this.child,
    this.isDelay = true,
    this.dismissKeyboard = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(dismissKeyboard) UtilsHelper.dismissKeyBoard();

        if(isDelay){
          Debounce.instance.runBefore(
            action: () {
              if (onTap != null) onTap!();
            },
          );
        }else{
          if (onTap != null) onTap!();
        }
      },
      child: child,
    );
  }
}
