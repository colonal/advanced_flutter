import 'package:advanced_flutter/data/data_sourse/remotr_data_sourse.dart';
import 'package:advanced_flutter/data/network/app_api.dart';
import 'package:advanced_flutter/data/network/dio_factory.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:advanced_flutter/data/repository/repository.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/forgot_usecase.dart';
import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/presentation/forgot_password/viewModel/forgot_password_viewmodel.dart';
import 'package:advanced_flutter/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../app/app_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance.registerLazySingleton<AppsPreferences>(
      () => AppsPreferences(sharedPreferences: instance()));

  // network info
  instance.registerLazySingleton<NetworckInfo>(
      () => NetworckInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(
      () => DioFactory(appsPreferences: instance()));

  Dio dio = await instance<DioFactory>().getDio();
  // App service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //  remote data source
  instance.registerLazySingleton<RemoteDataSourse>(
      () => RemoteDataSourseImpl(appServiceClient: instance()));

  //  repository
  instance.registerLazySingleton<Repository>(() =>
      RepositoryImpl(remoteDataSourse: instance(), networckInfo: instance()));
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUsecase>()) {
    instance.registerFactory<LoginUsecase>(() => LoginUsecase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));

    instance.registerFactory<ForgotUsecase>(() => ForgotUsecase(instance()));
    instance
        .registerFactory<ForgetViewModel>(() => ForgetViewModel(instance()));
  }
}
