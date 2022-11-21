import '../../../base/blocs/base_event.dart';

abstract class LoginEvent extends BaseEvent {
  @override
  List<Object?> get props => [];
}

class OnLoginPress extends LoginEvent{
  final String useName;
  final String password;

  OnLoginPress({required this.useName, required this.password});
}
