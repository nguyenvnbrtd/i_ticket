import 'package:flutter_animation/base/blocs/base_state.dart';

class TravelRouteState extends BaseState {
  final String departureTime;
  final String destinationTime;

  const TravelRouteState({required bool isLoading, required this.departureTime, required this.destinationTime}) : super(isLoading: isLoading);

  factory TravelRouteState.init() {
    return const TravelRouteState(
      isLoading: false,
      departureTime: '',
      destinationTime: '',
    );
  }

  TravelRouteState copyWith({bool? isLoading, String? departureTime, String? destinationTime}) {
    return TravelRouteState(
      isLoading: isLoading ?? this.isLoading,
      departureTime: departureTime ?? this.departureTime,
      destinationTime: destinationTime ?? this.destinationTime,
    );
  }

  @override
  List<Object?> get props => [isLoading, departureTime, destinationTime];
}
