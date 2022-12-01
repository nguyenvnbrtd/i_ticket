import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import '../../staless/spacer.dart';
import 'custom_bottom_navigator_item_model.dart';

class CustomBottomNavigatorItem extends StatelessWidget{
  const CustomBottomNavigatorItem({
    Key? key,
    required this.isSelected,
    required this.model,
    required this.onTap,
    required this.width,
    required this.height,

  }) : super(key: key);

  final double width;
  final double height;
  final bool isSelected;
  final VoidCallback onTap;
  final CustomBottomNavigatorItemModel model;

  final animationDuration = const Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final selectedColor = AppColors.blue600;

    final text = TextSpan(
      text: isSelected ? model.name : '',
      style: theme.textTheme.bodyMedium?.copyWith(color: isSelected ? selectedColor : null),
    );
    final textSize = (TextPainter(
      text: text,
      maxLines: 1,
      textScaleFactor: mediaQueryData.textScaleFactor,
      textDirection: TextDirection.ltr)..layout()
    ).size;

    final padding = textSize.width * 0.2;

    return AnimatedContainer(
      width: width,
      duration: animationDuration,
      alignment: Alignment.center,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.transparent,
              width: model.iconSize,
              height: model.iconSize,
              child: Center(child: Image.asset(model.icon, color: isSelected ? selectedColor : theme.unselectedWidgetColor, fit: BoxFit.contain,)),
            ),
           AnimatedContainer(
             duration: animationDuration,
             width: isSelected ? width - (model.iconSize + padding):0,
             child: Padding(
               padding: EdgeInsets.only(left: isSelected ? padding : 0),
               child: Align(
                 alignment: Alignment.centerLeft,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     RichText(text: text, maxLines: 1, overflow: TextOverflow.ellipsis),
                     SpaceVertical(height: padding / 4),
                     AnimatedContainer(
                       duration: animationDuration,
                       width: isSelected ? width + 5 : 0,
                       height: 3,
                       color: isSelected ? selectedColor : Colors.transparent,
                     )
                   ],
                 ),
               ),
             ),
           )
          ],
        ),
      ),
    );
  }
}
