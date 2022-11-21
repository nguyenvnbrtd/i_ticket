import 'package:flutter_animation/base/blocs/base_event.dart';

abstract class RegisterEvent extends BaseEvent{}

class OnRegisterPress extends RegisterEvent{
  final String email;
  final String password;
  final String confirmPassword;

  OnRegisterPress({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [email, password, confirmPassword];
}