import '../../../base/blocs/base_event.dart';

abstract class ForgotPasswordEvent extends BaseEvent {
  @override
  List<Object?> get props => [];
}

class OnForgotPasswordPress extends ForgotPasswordEvent{
  final String email;

  OnForgotPasswordPress({required this.email});

  @override
  List<Object?> get props => [email];
}
