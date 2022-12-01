import 'package:flutter_animation/main_bloc.dart';
import 'package:flutter_animation/repos/user_repository.dart';
import 'package:get_it/get_it.dart';

import 'core/utils/device_info.dart';
import 'core/utils/error_handler.dart';
import 'features/user_info/repos/user_info_repository.dart';

final it = GetIt.instance;

Future<void> init() async {
  // Repository
  it.registerLazySingleton<UserRepository>(() => UserRepository());
  it.registerLazySingleton<UserInfoRepository>(() => UserInfoRepository());

  //device information
  await DeviceInfo.init();

  final errorHandler = ErrorHandler();
  it.registerFactory<ErrorHandler>(() => errorHandler);

  MainBloc mainBloc = MainBloc();
  mainBloc.init(errorHandler, mainBloc);
}
