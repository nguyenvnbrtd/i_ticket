import './../../../base/blocs/base_state.dart';

class ForgotPasswordState extends BaseState {
  const ForgotPasswordState({required bool isLoading}):super(isLoading: isLoading);

  factory ForgotPasswordState.init(){
    return const ForgotPasswordState(isLoading: false);
  }

  ForgotPasswordState copyWith({bool? isLoading}) {
    return ForgotPasswordState(isLoading: isLoading ?? this.isLoading);
  }
}