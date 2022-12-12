import 'package:flutter/material.dart';
import 'package:flutter_animation/features/travel_route/models/travle_route.dart';

import '../../../../core/src/app_colors.dart';
import '../../../../widgets/staless/spacer.dart';
import '../../../travel_route/pages/widgets/seats_status.dart';

class HistorySeatsStatus extends SeatsStatus{
  final List<int>? selectedSeats;

  const HistorySeatsStatus({Key? key, required TravelRoute travelRoute, this.selectedSeats}) : super(key: key, travelRoute: travelRoute);

  @override
  List<Widget> buildIndicator(){
    return [
      const SpaceHorizontal(),
      StatusIndicator(color: AppColors.green400, label: 'Available'),
      StatusIndicator(color: AppColors.blue500, label: 'Your seats'),
      StatusIndicator(color: AppColors.red, label: 'Booked'),
      const SpaceHorizontal(),
    ];
  }

  @override
  List<Widget> seatITemBuilder(List<String> seats, BuildContext context) {
    final List<Widget> results = [];
    for (int index = 0; index < seats.length; index++) {
      final i = index + 1;
      String name = 'A';
      String number = '0';

      if(i % 4 != 0){
        number = (i ~/ 4 + 1).toString();
      }else{
        number = (i ~/ 4).toString();
      }

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
          defaultColor: (selectedSeats ?? []).contains(index) ? AppColors.blue500 : isEmpty ? AppColors.green400 : AppColors.red,
          selectedColor: AppColors.blue500,
          isBooking: booking,
          onTab: null,
        ),
      );
    }
    return results;
  }
}