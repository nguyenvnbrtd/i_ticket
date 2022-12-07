import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/widgets/staless/base_tab_widget.dart';
import 'package:flutter_animation/widgets/staless/spacer.dart';

import '../../models/item_selected.dart';
import '../../models/travle_route.dart';

class SeatsStatus extends StatelessWidget {
  final bool booking;
  final TravelRoute travelRoute;
  final ValueChanged<ItemSelected>? onItemTab;

  const SeatsStatus({Key? key, this.booking = false, required this.travelRoute, this.onItemTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final paddingSize = DeviceDimension.screenWidth * 0.05;

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Departure Day: ${UtilsHelper.getDateFromString(travelRoute.departureTime ?? ' ')}',
            style: theme.textTheme.headlineSmall,
          ),
          SpaceVertical(height: paddingSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SpaceHorizontal(),
              StatusIndicator(color: AppColors.green400, label: 'Available'),
              if (booking) StatusIndicator(color: AppColors.blue500, label: 'Selected'),
              StatusIndicator(color: AppColors.red, label: 'Booked'),
              const SpaceHorizontal(),
            ],
          ),
          SpaceVertical(height: paddingSize),
          SizedBox(
            width: DeviceDimension.screenWidth,
            child: Builder(
              builder: (context) {
                if ((travelRoute.seats ?? []).isEmpty) return const Text('Don\'t have data');

                return Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: seatITemBuilder(travelRoute.seats!, context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> seatITemBuilder(List<String> seats, BuildContext context) {
    final List<Widget> results = [];
    for (int index = 0; index < seats.length; index++) {
      final i = index + 1;
      String name = 'A';
      String number = (i ~/ 4 + 1).toString();
      final isEmpty = seats[index].isEmpty;

      if (i % 4 == 0) {
        name = 'D';
      } else if (i % 4 == 3) {
        name = 'C';
      } else if (i % 4 == 2) {
        name = 'B';
      } else if (i % 4 == 1) {
        name = 'A';
      }
      results.add(
        StatusItem(
          name: name,
          number: number,
          defaultColor: isEmpty ? AppColors.green400 : AppColors.red,
          selectedColor: AppColors.blue500,
          isBooking: booking,
          onTab: (isEmpty && onItemTab != null)
              ? (isSelected) {
                  onItemTab!(ItemSelected(index: index, isSelected: isSelected));
                }
              : null,
        ),
      );
    }
    return results;
  }
}

class StatusIndicator extends StatelessWidget {
  final Color color;
  final String label;

  const StatusIndicator({Key? key, required this.color, required this.label}) : super(key: key);

  final indicatorSize = 25.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: indicatorSize,
          height: indicatorSize,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(indicatorSize), color: color),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, color: AppColors.blue500),
        ),
      ],
    );
  }
}

class StatusItem extends StatefulWidget {
  final String name;
  final String number;
  final Color defaultColor;
  final Color selectedColor;
  final bool isBooking;
  final ValueChanged<bool>? onTab;

  const StatusItem({
    Key? key,
    this.onTab,
    required this.name,
    required this.number,
    this.isBooking = false,
    required this.defaultColor,
    required this.selectedColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatusItem();
}

class _StatusItem extends State<StatusItem> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paddingSize = DeviceDimension.padding;
    final itemSize = DeviceDimension.screenWidth * 0.15;
    Color color = isSelected ? widget.selectedColor : widget.defaultColor;
    if(widget.defaultColor == AppColors.red) color = AppColors.red;

    return BaseTabWidget(
      isDelay: false,
      onTap: () {
        if (widget.onTab != null) {
          if (widget.isBooking) {
            setState(() {
              isSelected = !isSelected;
              widget.onTab!(isSelected);
            });
          } else {
            widget.onTab!(isSelected);
          }
        }
      },
      child: Container(
        margin: EdgeInsets.all(paddingSize / 2).copyWith(right: widget.name == 'B' ? paddingSize * 2 : null),
        padding: EdgeInsets.symmetric(vertical: paddingSize / 2),
        width: itemSize,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(paddingSize * 0.6),
        ),
        child: Center(
          child: Text(
            '${widget.name}${widget.number}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
