import '../../../base/blocs/base_state.dart';

abstract class AuthenticationState extends BaseState {}

class AuthenticationStateInitial extends AuthenticationState{}
class AuthenticationStateLoggedIn extends AuthenticationState{}
class AuthenticationStateNotLoggedIn extends AuthenticationState{}