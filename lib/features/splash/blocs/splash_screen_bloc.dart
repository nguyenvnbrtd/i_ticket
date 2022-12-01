import '../../../base/blocs/base_bloc.dart';
import '../../../injector.dart';
import '../event/splash_screen_event.dart';
import '../state/splash_screen_state.dart';

class SplashScreenBloc extends BaseBloc<SplashScreenEvent, SplashScreenState> {

  SplashScreenBloc() : super(SplashScreenState()) {

  }
}
