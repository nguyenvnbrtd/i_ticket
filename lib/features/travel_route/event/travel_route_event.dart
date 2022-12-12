import 'package:flutter_animation/base/blocs/base_event.dart';
import 'package:flutter_animation/features/travel_route/models/travle_route.dart';

abstract class TravelRouteEvent extends BaseEvent{}

class OnInitRoute extends TravelRouteEvent{
  final String id;

  OnInitRoute({required this.id});

  @override
  List<Object?> get props => [id];
}

class OnAddNewRoute extends TravelRouteEvent{
  final TravelRoute route;

  OnAddNewRoute({required this.route});

  @override
  List<Object?> get props => [route];
}

class OnUpdateRoute extends TravelRouteEvent{
  final TravelRoute route;
  final String id;

  OnUpdateRoute({required this.id, required this.route});

  @override
  List<Object?> get props => [id, route];
}

class OnDeleteRoute extends TravelRouteEvent{
  final String id;

  OnDeleteRoute({required this.id});

  @override
  List<Object?> get props => [id];
}

class OnChangeDepartureTime extends TravelRouteEvent{
  final DateTime time;

  OnChangeDepartureTime({required this.time});

  @override
  List<Object?> get props => [time];
}

class OnChangeDestinationTime extends TravelRouteEvent{
  final DateTime time;

  OnChangeDestinationTime({required this.time});

  @override
  List<Object?> get props => [time];
}

class OnChangeButtonLabel extends TravelRouteEvent{
  final String label;

  OnChangeButtonLabel({required this.label});

  @override
  List<Object?> get props => [label];
}