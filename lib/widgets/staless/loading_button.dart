import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:flutter_animation/widgets/staless/primary_button.dart';

class LoadingButton extends StatelessWidget {
  final String label;
  final Color textColor;
  final VoidCallback onPress;
  final Color? color;
  final double minWidth;
  final bool isLoading;

  const LoadingButton(
      {Key? key,
      this.label = 'none',
      required this.onPress,
      this.color,
      this.textColor = Colors.white,
      this.minWidth = 50,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      key: key,
      onPress: () {
        if (isLoading) return;
        onPress();
      },
      color: color ?? AppColors.primary,
      label: label,
      minWidth: minWidth,
      textColor: textColor,
      child: isLoading
          ? Center(
            child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                ),
              ),
          )
          : null,
    );
  }
}
