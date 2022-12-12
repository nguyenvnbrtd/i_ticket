import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';

import 'custom_bottom_navigator_item.dart';
import 'custom_bottom_navigator_item_model.dart';

class CustomBottomNavigator extends StatefulWidget{
  const CustomBottomNavigator({
    Key? key,
    this.height = 50,
    required this.items,
    this.onSelectedChange,
    this.selectedIndex = 0,
    this.color = Colors.white,
  }) : super(key: key);


  final double height;
  final Color color;
  final int selectedIndex;
  final Function(int index)? onSelectedChange;
  final List<CustomBottomNavigatorItemModel> items;

  @override
  State<StatefulWidget> createState() => CustomBottomNavigatorState();
}

class CustomBottomNavigatorState extends State<CustomBottomNavigator> {

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);

    // calculate the size of the text
    final text = TextSpan(
      text: widget.items[widget.selectedIndex].name,
      style: theme.textTheme.bodyMedium,
    );

    final textSize = (TextPainter(
        text: text,
        maxLines: 1,
        textScaleFactor: mediaQueryData.textScaleFactor,
        textDirection: TextDirection.ltr)..layout()
    ).size;

    // then the size of the selected item is: icon size + text size * 1.4
    final size = mediaQueryData.size.width / (widget.items.length <= 2 ? widget.items.length : widget.items.length-1);
    double selectedWidth =  widget.items[widget.selectedIndex].iconSize + textSize.width * 1.4;

    if(selectedWidth < size){
      selectedWidth = size;
      // selectedWidth = selectedWidth * 1.4;
    }

    // then the rest of the width will be for the other item
    final normalWidth = (mediaQueryData.size.width - selectedWidth) / (widget.items.length-1);

    List<Widget> children = [];

    for(int index = 0; index < widget.items.length; index ++){
      final isSelected = index == widget.selectedIndex;

      children.add(CustomBottomNavigatorItem(
        model: widget.items[index],
        isSelected: isSelected,
        onTap: () => widget.onSelectedChange != null ? widget.onSelectedChange!(index) : (){},
        width: isSelected ? selectedWidth : normalWidth,
        height: widget.height,
        textWidth: textSize.width,
      ));
    }

    return Container(
      width: mediaQueryData.size.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.color,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            offset: const Offset(0, -2),
            blurRadius: 2,
          ),
        ]
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: children,
      ),
    );
  }
}
