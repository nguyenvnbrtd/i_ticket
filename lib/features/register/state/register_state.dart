import 'package:flutter_animation/base/blocs/base_state.dart';

class RegisterState extends BaseState{
  const RegisterState({required bool isLoading}):super(isLoading: isLoading);

  factory RegisterState.initial(){
    return const RegisterState(isLoading: false);
  }

  RegisterState copyWith({bool? isLoading}) {
    return RegisterState(isLoading: isLoading ?? this.isLoading);
  }
}