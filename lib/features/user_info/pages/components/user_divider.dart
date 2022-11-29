import 'package:flutter/cupertino.dart';
import 'package:flutter_animation/core/src/app_colors.dart';

class Divider extends StatelessWidget{
  const Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(10)
      ),
      height: 1,
    );
  }
}