import 'dart:async';
import 'dart:ffi';

import 'package:advanced_flutter/domain/model/models.dart';
import 'package:advanced_flutter/domain/usecase/home_usecase.dart';
import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final HomeUsecase homeUsecase;
  HomeViewModel({required this.homeUsecase});

  final StreamController<HomeViewObject> _homeObjectStreamController =
      BehaviorSubject<HomeViewObject>();

  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await homeUsecase.execute(Void)).fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  stateRendererType: StateRendererType.fullScreenErrorState,
                  message: failure.message)),
            }, (homeObject) {
      inputState.add(ContentState());

      inputHomeObject.add(HomeViewObject(
          banners: homeObject.data.banners,
          services: homeObject.data.services,
          stores: homeObject.data.stores));
    });
  }

  @override
  void dispose() {
    _homeObjectStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeObject => _homeObjectStreamController.sink;

  @override
  Stream<HomeViewObject> get outputHomeObject =>
      _homeObjectStreamController.stream
          .map((homeViewObject) => homeViewObject);
}

abstract class HomeViewModelInput {
  Sink get inputHomeObject;
}

abstract class HomeViewModelOutput {
  Stream<HomeViewObject> get outputHomeObject;
}

class HomeViewObject {
  List<Service> services;

  List<BannersAd> banners;

  List<Store> stores;
  HomeViewObject({
    required this.services,
    required this.banners,
    required this.stores,
  });
}
