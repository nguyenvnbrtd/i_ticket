import 'package:flutter/material.dart';
import 'package:flutter_animation/core/utils/debounce.dart';

class BaseTabWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? child;

  const BaseTabWidget({
    Key? key,
    this.onTap,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Debounce.instance.runAfter(
          action: () {
            if (onTap != null) onTap!();
          },
        );
      },
      child: child,
    );
  }
}
