import 'dart:async';

import '../../base/baseviewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/model/models.dart';
import '../../../domain/usecase/store_details_usecase.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final StoreDetailsUsecase usecase;
  final String id;
  final StreamController<StoreDetails> _storeDetailsStreamController =
      BehaviorSubject<StoreDetails>();

  StoreDetailsViewModel({required this.usecase, required this.id});

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((storeDetails) => storeDetails);

  @override
  void start() {
    _getStoreDetails();
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  void _getStoreDetails() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await usecase.execute(StoreDetailsUsecaseInput(id))).fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.fullScreenErrorState,
          message: failure.message));
    }, (storeDetails) {
      inputState.add(ContentState());
      inputStoreDetails.add(storeDetails);
    });
  }
}

abstract class StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}
