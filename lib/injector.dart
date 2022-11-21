import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animation/core/network/client/i_ticket_rest_client.dart';
import 'package:flutter_animation/main_bloc.dart';
import 'package:flutter_animation/repos/user_repository.dart';
import 'package:get_it/get_it.dart';

import 'core/utils/device_info.dart';
import 'core/utils/error_handler.dart';
import 'features/splash/repos/splash_repository.dart';

final it = GetIt.instance;

Future<void> init() async {
  // Repository
  it.registerFactory<SplashRepository>(() => SplashRepository());

  it.registerLazySingleton<UserRepository>(() => UserRepository());

  //device information
  await DeviceInfo.init();

  //! Core
  it.registerLazySingleton<ITicketRestClient>(() => ITicketRestClient());

  final errorHandler = ErrorHandler();
  it.registerFactory<ErrorHandler>(() => errorHandler);

  MainBloc mainBloc = MainBloc();
  mainBloc.init(errorHandler, mainBloc);
}
