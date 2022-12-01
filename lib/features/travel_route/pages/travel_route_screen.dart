import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../widgets/staless/main_label.dart';

class TravelRouteScreen extends StatefulWidget {
  const TravelRouteScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TravelRouteScreen();
}

class _TravelRouteScreen extends State<TravelRouteScreen> {
  final routeManagement = 'Route Management';

  @override
  Widget build(BuildContext context) {
    final paddingSize = DeviceDimension.screenWidth * 0.05;

    return OriginScreen(
      child: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: Column(
          children: [
            MainLabel(
              label: routeManagement,
              alignment: MainAxisAlignment.spaceBetween,
              rightIcon: Assets.plusCircleIcon,
              rightAction: onAddRoute,
            ),
          ],
        ),
      ),
    );
  }

  void onAddRoute() {
    Fluttertoast.showToast(msg: 'create new');
  }
}
