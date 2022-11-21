import '../../../base/blocs/base_bloc.dart';
import '../../../injector.dart';
import '../event/splash_screen_event.dart';
import '../repos/splash_repository.dart';
import '../state/splash_screen_state.dart';

class SplashScreenBloc extends BaseBloc<SplashScreenEvent, SplashScreenState> {
  final SplashRepository _splashRepository = it<SplashRepository>();

  SplashScreenBloc() : super(SplashScreenState()) {

  }
}
