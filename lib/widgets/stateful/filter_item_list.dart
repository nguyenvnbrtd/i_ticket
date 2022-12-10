import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:flutter_animation/core/utils/dimension.dart';

import '../staless/spacer.dart';


class FilterSearchList<T> extends StatefulWidget {
  final ValueChanged<T> onSelectedChange;
  final List<T> items;
  final String? label;

  const FilterSearchList(
      {Key? key,
      required this.onSelectedChange(T),
      required this.items,
      this.label})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FilterSearchList();
}

class _FilterSearchList extends State<FilterSearchList> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = DeviceDimension.screenWidth;
    double padding = width * 0.05;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) Container(
          padding: EdgeInsets.symmetric(horizontal: width*0.05),
          child: Text(widget.label!,
              style: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14)),
        ),
        if (widget.label != null) const SpaceVertical(height: 5),
        SizedBox(
          width: width,
          height: 40,
          // padding: EdgeInsets.symmetric(horizontal: width*0.05),
          child: ListView.builder(
              itemCount: widget.items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _FilterSearchListItem(
                  item: widget.items[index].toString(),
                  isSelected: currentIndex == index,
                  marginLeft: index == 0 ? padding : null,
                  marginRight: index + 1 == widget.items.length ? padding : null,
                  onTap: () {
                    widget.onSelectedChange(widget.items[index]);
                    setState(() {
                      currentIndex = index;
                    });
                  },
                );
              }),
        )
      ]
    );
  }
}

class _FilterSearchListItem extends StatelessWidget {
  final String item;
  final bool isSelected;
  final VoidCallback onTap;
  final double? marginLeft;
  final double? marginRight;
  final String? label;

  const _FilterSearchListItem(
      {Key? key,
      required this.item,
      this.isSelected = false,
      required this.onTap,
      this.marginLeft,
      this.marginRight,
      this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        margin: EdgeInsets.only(
            left: marginLeft ?? 5, right: marginRight ?? 5, top: 6, bottom: 6),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                  color: Colors.black45.withOpacity(0.3),
                  offset: const Offset(1, 2),
                  blurRadius: 2,
                  spreadRadius: 2)
            ]),
        child: Center(
          child: Text(
            item,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isSelected ? Colors.white : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
