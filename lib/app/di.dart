import '../data/data_sourse/local_data_source.dart';
import '../data/data_sourse/remotr_data_sourse.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecase/forgot_usecase.dart';
import '../domain/usecase/home_usecase.dart';
import '../domain/usecase/login_usecase.dart';
import '../domain/usecase/notification_usecase.dart';
import '../domain/usecase/register_usecase.dart';
import '../domain/usecase/search_usecase.dart';
import '../domain/usecase/store_details_usecase.dart';
import '../presentation/forgot_password/viewModel/forgot_password_viewmodel.dart';
import '../presentation/login/viewmodel/login_viewmodel.dart';
import '../presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import '../presentation/main/pages/notification/viewmodel/notification_viewmodel.dart';
import '../presentation/main/pages/search/viewmodel/search_viewmolel.dart';
import '../presentation/register/view_model/register_viewmodel.dart';
import '../presentation/store_details/viewmodel/store_details_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
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

  //  Local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  //  repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(
      remoteDataSourse: instance(),
      networckInfo: instance(),
      localDataSource: instance()));
}

void initForgetModule() {
  if (!GetIt.I.isRegistered<ForgotUsecase>()) {
    instance.registerFactory<ForgotUsecase>(() => ForgotUsecase(instance()));
    instance
        .registerFactory<ForgetViewModel>(() => ForgetViewModel(instance()));
  }
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUsecase>()) {
    instance.registerFactory<LoginUsecase>(() => LoginUsecase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

void initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUsecase>()) {
    instance
        .registerFactory<RegisterUsecase>(() => RegisterUsecase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));

    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

void initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUsecase>()) {
    instance.registerFactory<HomeUsecase>(() => HomeUsecase(instance()));
    instance.registerFactory<HomeViewModel>(
        () => HomeViewModel(homeUsecase: instance()));
  }
}

void initStoreDetails(String id) {
  if (!GetIt.I.isRegistered<StoreDetailsUsecase>()) {
    instance.registerFactory<StoreDetailsUsecase>(
        () => StoreDetailsUsecase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(
        () => StoreDetailsViewModel(usecase: instance(), id: id));
  }
}

void initNotification() {
  if (!GetIt.I.isRegistered<NotificationUsecase>()) {
    instance.registerFactory<NotificationUsecase>(
        () => NotificationUsecase(repository: instance()));
    instance.registerFactory<NotificationVewmodel>(
        () => NotificationVewmodel(usecase: instance()));
  }
}

void initSearch() {
  if (!GetIt.I.isRegistered<SearchUsecase>()) {
    instance.registerFactory<SearchUsecase>(
        () => SearchUsecase(repository: instance()));
    instance.registerFactory<SearchViewmodel>(
        () => SearchViewmodel(searchUsecase: instance()));
  }
}
