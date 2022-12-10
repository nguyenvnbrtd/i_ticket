import 'package:flutter/material.dart';
import 'package:flutter_animation/widgets/staless/base_tab_widget.dart';

const double edgSize = 8;

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    this.label = 'none',
    required this.onPress,
    this.color = Colors.teal,
    this.textColor = Colors.white,
    this.borderColor = Colors.white,
    this.borderRadius = edgSize,
    this.height = 45,
    this.width,
    this.borderWidth = 1,
    this.child,
  }) : super(key: key);

  final String label;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onPress;
  final Color color;
  final double height;
  final double? width;
  final double borderWidth;
  final double borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      child: BaseTabWidget(
        onTap: onPress,
        child: Container(
          height: height,
          width: width,
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.all(edgSize),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: Center(
            child: child ??
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 18),
                ),
          ),
        ),
      ),
    );
  }
}
