import 'package:flutter/material.dart';
import 'package:flutter_animation/features/travel_route/models/travle_route.dart';
import 'package:flutter_animation/features/travel_route/pages/components/travel_route_item.dart';

import '../../../../core/src/app_colors.dart';
import '../../../../core/utils/dimension.dart';
import '../../../../widgets/stateful/expand_widget.dart';
import '../widgets/seats_status.dart';

class BookingRouteItem extends TravelRouteItem {
  const BookingRouteItem({Key? key, required TravelRoute item}) : super(key: key, item: item);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceDimension.padding),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4.5),
            color: AppColors.lightGrey.withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: buildContent(context),
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return ExpandWidget(
      main: Padding(
        padding: EdgeInsets.all(DeviceDimension.padding),
        child: super.buildContent(context),
      ),
      child: SeatsStatus(
        travelRoute: item,
        booking: true,
        onItemTab: (value) {},
      ),
    );
  }
}
