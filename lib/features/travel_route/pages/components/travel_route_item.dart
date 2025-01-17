import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/core/utils/dialog_utils.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/travel_route/blocs/travel_route_bloc.dart';
import 'package:flutter_animation/features/travel_route/event/travel_route_event.dart';
import 'package:flutter_animation/features/travel_route/models/travle_route.dart';
import 'package:flutter_animation/route/page_routes.dart';
import 'package:flutter_animation/widgets/staless/base_tab_widget.dart';
import 'package:flutter_animation/widgets/staless/spacer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants.dart';
import '../../../../models/navigator_agruments/travel_route_argument.dart';

class TravelRouteItem extends StatefulWidget {
  final TravelRoute item;
  final ValueChanged<TravelRoute>? onTab;

  const TravelRouteItem({Key? key, required this.item, this.onTab}) : super(key: key);

  @override
  State<TravelRouteItem> createState() => TravelRouteItemState();
}

class TravelRouteItemState extends State<TravelRouteItem> {
  final deleteAlert = 'Delete route';

  final deleteMessage = 'Do you want to delete it?';

  final paddingSize = DeviceDimension.screenWidth * 0.05;

  final iconSize = DeviceDimension.screenWidth * 0.07;

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
          if (widget.onTab != null) return BaseTabWidget(onTap: () => widget.onTab!(widget.item), child: buildContent(context));
          return buildContent(context);
        },
      ),
    );
  }

  Widget buildContent(BuildContext context){
    final theme = Theme.of(context);
    final name = widget.item.name!;
    final travelTime =
        '${UtilsHelper.getTimeFromString(widget.item.departureTime!)} - ${UtilsHelper.getTimeFromString(widget.item.destinationTime!)}';
    final license = widget.item.licensePlate!;
    final price = '${UtilsHelper.formatMoney(widget.item.price ?? 0)} ${Constants.PRICE_TYPE}';
    final departure = widget.item.departureName!;
    final destination = widget.item.destinationName!;
    final routeStatus =
        '${widget.item.distance}km - ${UtilsHelper.getDiffHoursFromTwo(widget.item.departureTime!, widget.item.destinationTime!)}';

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
            Container(
              padding: EdgeInsets.symmetric(horizontal: paddingSize / 1.5, vertical: paddingSize / 3),
              decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(paddingSize)),
              child: Text(price, style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.grey)),
            ),
            buildEmptySeatsNumber(context),
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
        buildAction(context),
      ],
    );
  }

  void onEdit() {
    UtilsHelper.pushNamed(Routes.addTravelRoute, TravelRouteArgument(widget.item.id ?? ''));
  }

  void onDelete(BuildContext context) {
    DialogUtils.showPrimaryDialog(
        barrierDismissible: true,
        closeWhenAction: true,
        label: deleteAlert,
        message: deleteMessage,
        onCancel: () {},
        onConfirm: () {
          context.read<TravelRouteBloc>().add(OnDeleteRoute(id: widget.item.id!));
        });
  }

  Widget buildAction(BuildContext context){
    return Positioned(
      bottom: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          BaseTabWidget(
            child: Padding(
              padding: EdgeInsets.all(DeviceDimension.padding/2).copyWith(bottom: 0),
              child: Image.asset(Assets.editIcon, height: iconSize, fit: BoxFit.contain),
            ),
            onTap: onEdit,
          ),
          BaseTabWidget(
            child: Padding(
              padding: EdgeInsets.all(DeviceDimension.padding/2).copyWith(bottom: 0, right: 0),
              child: Image.asset(Assets.trashIcon, height: iconSize, fit: BoxFit.contain),
            ),
            onTap: () => onDelete(context),
          )
        ],
      ),
    );
  }

  Widget buildEmptySeatsNumber(BuildContext context) {
    return Container();
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
