import '../../../base/blocs/base_bloc.dart';
import '../../../injector.dart';
import '../../../repos/user_repository.dart';
import '../../../route/page_routes.dart';
import '../../utils/utils_helper.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends BaseBloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository = it();

  AuthenticationBloc() : super(AuthenticationStateInitial()) {
    on<OnStartAuthentication>((event, emit) async {
      final user = await _userRepository.getUser();
      if (user != null) {
        emit(AuthenticationStateLoggedIn(id: user.uid));
      } else {
        emit(AuthenticationStateNotLoggedIn());
      }
    });

    on<AuthenticationEventLoggingIn>((event, emit) {
      emit(AuthenticationStateLoggedIn(id: event.userId));
    });

    on<AuthenticationEventLoggingOut>((event, emit) {
      emit(AuthenticationStateNotLoggedIn());
    });
  }
}
