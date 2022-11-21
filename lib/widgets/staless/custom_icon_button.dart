import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {

  const CustomIconButton({
    Key? key,
    required this.onPress,
    this.icon = Icons.location_searching,
    this.color = Colors.cyan,
    this.iconColor = Colors.white
  }) : super(key: key);

  final VoidCallback onPress;
  final IconData icon;
  final Color color;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(25)),
      child: IconButton(

        icon: Icon(
          icon,
          color: iconColor,
        ),
        onPressed: onPress,
      ),
    );
  }
}
