import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/assets.dart';

class EmptyWidget extends StatelessWidget{
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(Assets.emptyImage),
    );
  }
}