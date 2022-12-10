import '../../../base/blocs/base_state.dart';

class BookingState extends BaseState {
  List<int> selectedIndexs;

  BookingState({required bool isLoading, required this.selectedIndexs}) : super(isLoading: isLoading);

  factory BookingState.init() {
    return BookingState(
      isLoading: false,
      selectedIndexs: const [],
    );
  }

  BookingState copyWith({bool? isLoading, List<int>? selectedIndexs}) {
    return BookingState(
      isLoading: isLoading ?? this.isLoading,
      selectedIndexs: selectedIndexs ?? this.selectedIndexs,
    );
  }

  @override
  List<Object?> get props => [isLoading, selectedIndexs];
}
