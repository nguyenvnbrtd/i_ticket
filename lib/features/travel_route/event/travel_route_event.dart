import 'package:flutter_animation/base/blocs/base_event.dart';
import 'package:flutter_animation/features/travel_route/models/travle_route.dart';

abstract class TravelRouteEvent extends BaseEvent{}

class OnAddNewRoute extends TravelRouteEvent{
  final TravelRoute route;

  OnAddNewRoute({required this.route});

  @override
  List<Object?> get props => [route];
}