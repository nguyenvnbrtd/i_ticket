import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/widgets/stateful/text_input.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChange;

  const SearchBar({Key? key, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DeviceDimension.padding),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: DeviceDimension.padding),
              child: Stack(
                children: [
                  TextInput(controller: TextEditingController(), onTextChange: onChange),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Container(decoration: BoxDecoration(border: Border.all(width: 0.5))),
                  )
                ],
              ),
            ),
          ),
          Image.asset(Assets.searchIcon, height: DeviceDimension.screenWidth * 0.1),
        ],
      ),
    );
  }
}
