import 'package:advanced_flutter/app/app_preferences.dart';
import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/on_boarding/viewmodel/onboarding_viewmodel.dart';
import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/constants_manager.dart';
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter/presentation/resources/string_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/model/models.dart';

class OnBpBpardingView extends StatefulWidget {
  const OnBpBpardingView({Key? key}) : super(key: key);

  @override
  State<OnBpBpardingView> createState() => _OnBpBpardingViewState();
}

class _OnBpBpardingViewState extends State<OnBpBpardingView> {
  late PageController _controller;

  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  final AppsPreferences _appsPreferences = instance<AppsPreferences>();

  _build() {
    _appsPreferences.setOnBoardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _build();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) return Container();

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        shadowColor: ColorManager.white,
        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: sliderViewObject.numberOfSlides,
        onPageChanged: (index) {
          _viewModel.onPageChanged(index);
        },
        itemBuilder: (_, index) =>
            OnBoardingPage(sliderViewObject.sliderObject),
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
                },
                child: Text(
                  AppStrings.skip,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            _getBottomSheetWidget(sliderViewObject),
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              _controller.animateToPage(_viewModel.goPrevious(),
                  duration: const Duration(
                      milliseconds: ConstantsManager.sliderAnimation),
                  curve: Curves.bounceInOut);
            },
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              sliderViewObject.numberOfSlides,
              (index) => Padding(
                padding: const EdgeInsets.all(AppPadding.p14),
                child: SvgPicture.asset(_getProperCircal(
                    index: index, currentindex: sliderViewObject.currentIndex)),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _controller.animateToPage(_viewModel.goNext(),
                  duration: const Duration(
                      milliseconds: ConstantsManager.sliderAnimation),
                  curve: Curves.bounceInOut);
            },
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getProperCircal({required int index, required int currentindex}) {
    if (index == currentindex) {
      return ImageAssets.hollowCirlceIc;
    } else {
      return ImageAssets.solidCircleIc;
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject sliderObject;
  const OnBoardingPage(this.sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(sliderObject.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(sliderObject.subTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium),
        ),
        const SizedBox(height: AppSize.s60),
        SvgPicture.asset(sliderObject.image),
      ],
    );
  }
}
