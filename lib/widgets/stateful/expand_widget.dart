import 'package:flutter/material.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/widgets/staless/base_tab_widget.dart';

class ExpandWidget extends StatefulWidget {
  final Widget main;
  final Widget child;
  bool expand;

  ExpandWidget({
    Key? key,
    required this.main,
    required this.child,
    this.expand = false,
  }) : super(key: key);

  @override
  _QuestionAnswerItemState createState() => _QuestionAnswerItemState();
}

class _QuestionAnswerItemState extends State<ExpandWidget> with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> expandAnimation;
  late Size widgetSize;

  @override
  void initState() {
    expandController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    expandAnimation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _runExpandCheck();
    });

    super.initState();
  }

  void _runExpandCheck() {
    if(expandController.isCompleted){
      widget.expand = true;
      return;
    }
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  void _run() {
    if (widget.expand) {
      expandController.reverse();
      widget.expand = false;
    } else {
      expandController.forward();
      widget.expand = true;
    }
    setState(() {});
  }

  @override
  void didUpdateWidget(ExpandWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widgetSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          BaseTabWidget(
            onTap: _run,
            child: widget.main,
          ),
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: expandAnimation,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
