import '../../../base/blocs/base_event.dart';

abstract class AuthenticationEvent extends BaseEvent {}

class OnStartAuthentication extends AuthenticationEvent{}

class AuthenticationEventLoggingIn extends AuthenticationEvent{
  final String userId;

  AuthenticationEventLoggingIn({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class AuthenticationEventLoggingOut extends AuthenticationEvent{}