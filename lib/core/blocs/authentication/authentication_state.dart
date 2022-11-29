import '../../../base/blocs/base_state.dart';

abstract class AuthenticationState extends BaseState {}

class AuthenticationStateInitial extends AuthenticationState{}
class AuthenticationStateLoggedIn extends AuthenticationState{
  final String id;

  AuthenticationStateLoggedIn({required this.id});

  @override
  List<Object?> get props => [id];
}
class AuthenticationStateNotLoggedIn extends AuthenticationState{}