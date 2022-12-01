import 'package:flutter/material.dart';
import 'package:flutter_animation/widgets/staless/base_tab_widget.dart';

import '../../core/src/app_colors.dart';

class MainLabel extends StatelessWidget {
  final String label;
  final String rightIcon;
  final VoidCallback? rightAction;
  final MainAxisAlignment alignment;
  final double widgetSize;

  const MainLabel({
    Key? key,
    this.label = 'none',
    this.rightIcon = '',
    this.rightAction,
    this.alignment = MainAxisAlignment.center,
    this.widgetSize = 22,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: alignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: theme.textTheme.headlineSmall?.copyWith(fontSize: widgetSize)),
        if (rightIcon.isNotEmpty)
          BaseTabWidget(
            onTap: rightAction,
            child: Image.asset(rightIcon, color: AppColors.primary, width: widgetSize, height: widgetSize),
          ),
      ],
    );
  }
}
