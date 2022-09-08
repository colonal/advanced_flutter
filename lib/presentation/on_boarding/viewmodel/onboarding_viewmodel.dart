import 'dart:async';

import 'package:advanced_flutter/domain/model/models.dart';
import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';

import '../../resources/assets_manager.dart';
import '../../resources/string_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInput, OnBoardingViewModleOutput {
  // stream controllers outputs
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int previousIndex = ++_currentPageIndex;
    if (previousIndex == _list.length) {
      previousIndex = 0;
    }
    return previousIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentPageIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }

    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentPageIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onBoardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onBoardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onBoardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onBoardingLogo4),
      ];

  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
        _list[_currentPageIndex], _list.length, _currentPageIndex));
  }
}

abstract class OnBoardingViewModelInput {
  int goNext();
  int goPrevious();
  void onPageChanged(int index);
  // stream controller input
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModleOutput {
  Stream<SliderViewObject> get outputSliderViewObject;
}
