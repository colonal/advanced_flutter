import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/forgot_password/view/forgot_password_view.dart';
import 'package:advanced_flutter/presentation/login/view/lodin_view.dart';
import 'package:advanced_flutter/presentation/main/main_view.dart';
import 'package:advanced_flutter/presentation/on_boarding/view/on_bparding_view.dart';
import 'package:advanced_flutter/presentation/register/view/register_view.dart';
import 'package:advanced_flutter/presentation/resources/string_manager.dart';
import 'package:advanced_flutter/presentation/splash/splash_view.dart';
import 'package:advanced_flutter/presentation/store_details/view/store_details_view.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBpardingRoute = "onBparding";
  static const String loginRoute = "/login";
  static const String registerRout = "/register";
  static const String forgotPaswwordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBpardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBpBpardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRout:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPaswwordRoute:
        initForgetModule();
        return MaterialPageRoute(builder: (_) => const ForgotPassworedView());
      case Routes.mainRoute:
        initHomeModule();
        initNotification();
        initSearch();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        initStoreDetails(arguments as String? ?? "1");

        return MaterialPageRoute(builder: (_) => const StoreDetailsView());

      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(AppStrings.noRouteFound.tr())),
        body: Center(
          child: Text(AppStrings.noRouteFound.tr()),
        ),
      ),
    );
  }
}
