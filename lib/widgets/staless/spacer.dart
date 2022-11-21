import 'package:flutter/material.dart';

class Space extends StatelessWidget{
  const Space({Key? key, this.height = 0 , this.width = 0}) : super(key: key);

  final double height;
  final double width;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}

class SpaceHorizontal extends Space{
  const SpaceHorizontal({Key? key, double? width}) : super(key: key, width: width ?? 20);
}

class SpaceVertical extends Space{
  const SpaceVertical({Key? key, double? height}) : super(key: key, height: height ?? 20);
}