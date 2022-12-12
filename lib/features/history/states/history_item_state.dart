import '../../../base/blocs/base_state.dart';
import '../../travel_route/models/travle_route.dart';

class HistoryItemState extends BaseState {
  final TravelRoute route;

  const HistoryItemState({required bool isLoading, required this.route}) : super(isLoading: isLoading);

  factory HistoryItemState.init() {
    return HistoryItemState(
      isLoading: false,
      route: TravelRoute(),
    );
  }

  HistoryItemState copyWith({bool? isLoading, TravelRoute? route}) {
    return HistoryItemState(
      isLoading: isLoading ?? this.isLoading,
      route: this.route.copyWith(data: route),
    );
  }

  @override
  List<Object?> get props => [isLoading, route];
}
