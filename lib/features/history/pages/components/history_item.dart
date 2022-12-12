import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/core/utils/dialog_utils.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/history/pages/widgets/history_seats_status.dart';
import 'package:flutter_animation/features/history/states/history_item_state.dart';
import 'package:flutter_animation/widgets/staless/base_tab_widget.dart';
import 'package:flutter_animation/widgets/staless/spacer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants.dart';
import '../../../booking/models/booking_detail.dart';
import '../../blocs/history_item_cubit.dart';

class HistoryItem extends StatelessWidget {
  final BookingDetail item;

  HistoryItem({Key? key, required this.item}) : super(key: key);

  final deleteAlert = 'Delete route';

  final deleteMessage = 'Do you want to delete it?';

  final paddingSize = DeviceDimension.screenWidth * 0.05;

  final iconSize = DeviceDimension.screenWidth * 0.07;

  @override
  Widget build(BuildContext context) {

    final isPaid = item.isPayed ?? false;

    return BlocProvider(
      create: (_) => HistoryItemCubit()..initData(item.routeId ?? ''),
      child: Container(
        decoration: BoxDecoration(
          color: isPaid ? AppColors.blue300 : AppColors.white,
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
        child: BlocBuilder<HistoryItemCubit, HistoryItemState>(
          builder: (context, state) {
            return BaseTabWidget(onTap: ()=> onItemTab(state, context), child: buildContent(context, state));
          },
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context, HistoryItemState state){
    final theme = Theme.of(context);
    final name = state.route.name ?? '';
    final travelTime =
        '${UtilsHelper.getTimeFromString(state.route.departureTime ?? '')} - ${UtilsHelper.getTimeFromString(state.route.destinationTime ?? '')}';
    final license = state.route.licensePlate ?? '';
    final seats = item.seats?.map((e) => UtilsHelper.getSeatName(e)).join(', ');
    final departure = state.route.departureName ?? '';
    final destination = state.route.destinationName ?? '';
    final routeStatus =
        '${state.route.distance}km - ${UtilsHelper.getDiffHoursFromTwo(state.route.departureTime ?? '', state.route.destinationTime ?? '')}';

    final isPaid = item.isPayed ?? false;
    return Column(
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
          child: Text('$license - $seats', style: theme.textTheme.bodyMedium?.copyWith(color: isPaid ? AppColors.primary : AppColors.grey)),
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
                  HistoryDot(),
                  HistoryDot(),
                  HistoryDot(),
                  HistoryDot(),
                  HistoryDot(),
                ],
              ),
              left: iconSize / 2,
              top: iconSize,
              bottom: iconSize,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildEmptySeatsNumber(BuildContext context) {
    return Container();
  }

  void onItemTab(HistoryItemState state, BuildContext context) {
    if(state.isLoading) return;
    final price = '${UtilsHelper.formatMoney(state.route.price! * (item.seats?.length ?? 0))} ${Constants.PRICE_TYPE}';
    final isPaid = item.isPayed ?? false;
    final theme = Theme.of(context);

    DialogUtils.showBottomSheetDialog(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(DeviceDimension.padding),
            child: Column(
              children: [
                Text('Payment: ${isPaid ? 'Paid' : 'UnPaid'}', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, color: isPaid ? AppColors.green : AppColors.red)),
                Text('Price: $price', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, color: isPaid ? AppColors.green : AppColors.red)),
                SpaceVertical(height: DeviceDimension.padding),
                HistorySeatsStatus(travelRoute: state.route, selectedSeats: item.seats),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryDot extends StatelessWidget {
  const HistoryDot({Key? key}) : super(key: key);

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
