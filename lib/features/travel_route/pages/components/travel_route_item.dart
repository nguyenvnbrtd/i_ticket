import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/core/utils/dialog_utils.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/travel_route/blocs/travel_route_bloc.dart';
import 'package:flutter_animation/features/travel_route/event/travel_route_event.dart';
import 'package:flutter_animation/features/travel_route/models/travle_route.dart';
import 'package:flutter_animation/features/travel_route/pages/widgets/seats_status.dart';
import 'package:flutter_animation/route/page_routes.dart';
import 'package:flutter_animation/widgets/staless/base_tab_widget.dart';
import 'package:flutter_animation/widgets/staless/spacer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/travel_route_argument.dart';
import '../../../../widgets/stateful/expand_widget.dart';

class TravelRouteItem extends StatelessWidget {
  final TravelRoute item;
  final ValueChanged<TravelRoute>? onTab;

  const TravelRouteItem({Key? key, required this.item, this.onTab}) : super(key: key);

  final deleteAlert = 'Delete route';
  final deleteMessage = 'Do you want to delete it?';

  @override
  Widget build(BuildContext context) {

    return Container(
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
      padding: EdgeInsets.all(DeviceDimension.padding),
      child: Builder(
        builder: (context) {
          if (onTab != null) return BaseTabWidget(onTap: () => onTab!(item), child: buildContent(context));
          return buildContent(context);
        },
      ),
    );
  }

  Widget buildContent(BuildContext context){
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

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SpaceHorizontal(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(travelTime, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            SpaceVertical(height: paddingSize / 2),
            Container(
              padding: EdgeInsets.symmetric(horizontal: paddingSize / 1.5, vertical: paddingSize / 3),
              decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(paddingSize)),
              child: Text(license, style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.grey)),
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
                        Text(
                          routeStatus,
                          style: theme.textTheme.bodySmall?.copyWith(color: AppColors.grey, fontSize: 12),
                        ),
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
                onTap: () => onDelete(context),
              )
            ],
          ),
        ),
      ],
    );
  }

  void onEdit() {
    UtilsHelper.pushNamed(Routes.addTravelRoute, TravelRouteArgument(item.id ?? ''));
  }

  void onDelete(BuildContext context) {
    DialogUtils.showPrimaryDialog(
        barrierDismissible: true,
        closeWhenAction: true,
        label: deleteAlert,
        message: deleteMessage,
        onCancel: () {},
        onConfirm: () {
          context.read<TravelRouteBloc>().add(OnDeleteRoute(id: item.id!));
        });
  }
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
