import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/travel_route/models/travle_route.dart';
import 'package:flutter_animation/widgets/staless/base_tab_widget.dart';
import 'package:flutter_animation/widgets/staless/spacer.dart';

class TravelRouteItem extends StatelessWidget {
  final TravelRoute item;

  const TravelRouteItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = item.name!;
    final travelTime =
        '${UtilsHelper.getTimeFromString(item.departureTime!)} - ${UtilsHelper.getTimeFromString(item.destinationTime!)}';
    final license = item.licensePlate!;
    final departure = item.departureName!;
    final destination = item.destinationName!;
    final routeStatus =
        '${item.distance}km - ${UtilsHelper.getDiffHoursFromTwo(item.departureTime!, item.destinationTime!)}';

    final paddingSize = DeviceDimension.screenWidth * 0.05;
    final iconSize = DeviceDimension.screenWidth * 0.07;

    return BaseTabWidget(
      onTap: onTab,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(paddingSize),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4.5),
              color: AppColors.lightGrey.withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ],
        ),
        padding: EdgeInsets.all(paddingSize),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(name, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500)),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(travelTime, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
                SpaceVertical(height: paddingSize / 2),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: paddingSize / 1.5, vertical: paddingSize / 3),
                  decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(paddingSize)),
                  child: Text(
                    license,
                    style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                  ),
                ),
                SpaceVertical(height: paddingSize / 2),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(Assets.departureCircleIcon, height: iconSize, fit: BoxFit.contain),
                            SpaceHorizontal(width: paddingSize / 2),
                            Text(departure, style: theme.textTheme.bodyMedium),
                          ],
                        ),
                        SpaceVertical(height: paddingSize),
                        Row(
                          children: [
                            SizedBox(width: iconSize + paddingSize / 2),
                            Text(routeStatus,
                                style: theme.textTheme.bodySmall?.copyWith(color: AppColors.grey, fontSize: 12)),
                          ],
                        ),
                        SpaceVertical(height: paddingSize),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(Assets.destinationCircleIcon, height: iconSize, fit: BoxFit.contain),
                            SpaceHorizontal(width: paddingSize / 2),
                            Text(destination, style: theme.textTheme.bodyMedium),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          TravelRouteDot(),
                          TravelRouteDot(),
                          TravelRouteDot(),
                          TravelRouteDot(),
                          TravelRouteDot(),
                        ],
                      ),
                      left: iconSize / 2,
                      top: iconSize,
                      bottom: iconSize,
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BaseTabWidget(
                    child: Image.asset(Assets.editIcon, height: iconSize, fit: BoxFit.contain),
                    onTap: onEdit,
                  ),
                  SpaceHorizontal(width: paddingSize / 2),
                  BaseTabWidget(
                    child: Image.asset(Assets.trashIcon, height: iconSize, fit: BoxFit.contain),
                    onTap: onDelete,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTab() {}

  void onEdit() {}

  void onDelete() {}
}

class TravelRouteDot extends StatelessWidget {
  const TravelRouteDot({Key? key}) : super(key: key);

  final double size = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(size / 2)),
    );
  }
}
