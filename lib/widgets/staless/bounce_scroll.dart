import 'package:flutter/material.dart';
import 'package:flutter_animation/core/utils/dimension.dart';

class BounceScroll extends StatelessWidget{
  final Widget? child;

  const BounceScroll({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: child);
  }

}