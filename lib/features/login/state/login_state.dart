import './../../../base/blocs/base_state.dart';

class LoginState extends BaseState {
  const LoginState({required bool isLoading}):super(isLoading: isLoading);

  factory LoginState.init(){
    return const LoginState(isLoading: false);
  }

  LoginState copyWith({bool? isLoading}) {
    return LoginState(isLoading: isLoading ?? this.isLoading);
  }
}