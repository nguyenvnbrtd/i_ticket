import 'package:flutter_animation/base/blocs/base_state.dart';
import 'package:flutter_animation/features/travel_route/models/travle_route.dart';

class TravelRouteState extends BaseState {
  final TravelRoute route;
  final bool isInitData;
  final String buttonLabel;

  const TravelRouteState({required bool isLoading, required this.isInitData, required this.route, this.buttonLabel = 'Next'}) : super(isLoading: isLoading);

  factory TravelRouteState.init() {
    return TravelRouteState(
      isLoading: false,
      isInitData: false,
      buttonLabel: 'Next',
      route: TravelRoute(),
    );
  }

  TravelRouteState copyWith({bool? isLoading, bool? isInitData,String? buttonLabel, TravelRoute? route}) {
    return TravelRouteState(
      isLoading: isLoading ?? this.isLoading,
      isInitData: isInitData ?? this.isInitData,
      buttonLabel: buttonLabel ?? this.buttonLabel,
      route: this.route.copyWith(data: route),
    );
  }

  @override
  List<Object?> get props => [isLoading, isInitData, buttonLabel, route];
}
