import 'dart:async';

import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModleOutputs {
  final StreamController<FlowState> _inputStreamControll =
      StreamController<FlowState>.broadcast();

  @override
  Stream<FlowState> get outputState =>
      _inputStreamControll.stream.map((flowState) => flowState);

  @override
  Sink get inputState => _inputStreamControll.sink;

  @override
  void dispose() {
    _inputStreamControll.close();
  }
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();

  Sink get inputState;
}

abstract class BaseViewModleOutputs {
  Stream<FlowState> get outputState;
}
