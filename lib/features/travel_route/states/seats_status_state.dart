import '../../../base/blocs/base_state.dart';
import '../models/travle_route.dart';

class SeatsStatusState extends BaseState {
  final TravelRoute route;

  const SeatsStatusState({required bool isLoading, required this.route}) : super(isLoading: isLoading);

  factory SeatsStatusState.init() {
    return SeatsStatusState(
      isLoading: false,
      route: TravelRoute(),
    );
  }

  SeatsStatusState copyWith({bool? isLoading, TravelRoute? route}) {
    return SeatsStatusState(
      isLoading: isLoading ?? this.isLoading,
      route: this.route.copyWith(data: route),
    );
  }

  @override
  List<Object?> get props => [isLoading, route, route.seats];
}
