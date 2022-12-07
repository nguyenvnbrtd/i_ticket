import 'package:flutter/material.dart';
import 'package:flutter_animation/features/travel_route/models/item_selected.dart';
import 'package:flutter_animation/features/travel_route/pages/travel_route_screen.dart';

import '../../../widgets/staless/main_label.dart';
import '../models/travle_route.dart';
import 'components/booking_route_item.dart';

class BookingScreen extends TravelRouteScreen {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookingScreen();
}

class _BookingScreen extends TravelRouteScreenState {

  @override
  String get title => 'Booking Ticket';

  @override
  Widget buildHeader() {
    return MainLabel(label: title);
  }

  @override
  Widget buildItem(TravelRoute item) {
    return BookingRouteItem(item: item);
  }

}
