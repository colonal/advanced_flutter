import 'dart:async';

import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/constants_manager.dart';
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

import '../../app/app_preferences.dart';
import '../../app/di.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppsPreferences _appsPreferences = instance<AppsPreferences>();

  _startDelay() {
    _timer =
        Timer(const Duration(seconds: ConstantsManager.splashDelay), _goNext);
  }

  _goNext() async {
    _appsPreferences.isUserLoggedIn().then(
      (isUserLoggedIn) {
        if (isUserLoggedIn) {
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
          // Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
        } else {
          _appsPreferences.isOnBoardingScreenViewed().then(
            (isOnBoardingScreenViewed) {
              if (isOnBoardingScreenViewed) {
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
              } else {
                Navigator.of(context)
                    .pushReplacementNamed(Routes.onBpardingRoute);
              }
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image.asset(ImageAssets.splashLogo),
      ),
    );
  }
}
