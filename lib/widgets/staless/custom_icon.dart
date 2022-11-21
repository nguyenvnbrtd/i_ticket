import 'package:flutter/cupertino.dart';

import '../../core/src/assets.dart';

class CustomIcon extends StatelessWidget{
  final double size;
  final String? icon;

  const CustomIcon({Key? key, this.size = 20, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(icon ?? Assets.eyeIcon, fit: BoxFit.contain),
    );
  }
}