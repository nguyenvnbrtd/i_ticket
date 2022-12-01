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
    this.height = 45,
    this.child,
  }) : super(key: key);

  final String label;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onPress;
  final Color color;
  final double height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: color,
      borderRadius: BorderRadius.circular(edgSize),
      child: BaseTabWidget(
        onTap: onPress,
        child: Container(
          height: height,
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.all(edgSize),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(edgSize),
            border: Border.all(color: borderColor, width: 1),
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
