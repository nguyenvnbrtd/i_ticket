import 'package:flutter/cupertino.dart';
import 'package:flutter_animation/core/src/app_colors.dart';

class UserDivider extends StatelessWidget{
  const UserDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10)
      ),
      height: 1,
    );
  }
}