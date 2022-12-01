import 'package:flutter_animation/base/blocs/base_state.dart';

class UserInfoState extends BaseState {
  final bool isInfoChanged;

  const UserInfoState({required bool isLoading, required this.isInfoChanged}) : super(isLoading: isLoading);

  factory UserInfoState.init() {
    return const UserInfoState(
      isLoading: false,
      isInfoChanged: false,
    );
  }

  UserInfoState copyWith({bool? isLoading, bool? isInfoChanged}) {
    return UserInfoState(
      isLoading: isLoading ?? this.isLoading,
      isInfoChanged: isInfoChanged ?? this.isInfoChanged,
    );
  }

  @override
  List<Object?> get props => [isLoading, isInfoChanged];
}
