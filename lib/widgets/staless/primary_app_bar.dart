import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/widgets/staless/base_tab_widget.dart';

class PrimaryAppBar extends StatelessWidget with PreferredSizeWidget{
  const PrimaryAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: BaseTabWidget(
        onTap: ()=> UtilsHelper.pop(),
        child: Center(child: Image.asset(Assets.backIcon, width: 25, height: 25, fit:  BoxFit.contain)),
      ),
    );
  }

  @override
  Size get preferredSize => Size(0, 50);
}