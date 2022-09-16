import 'dart:async';

import '../common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModleOutputs {
  final StreamController<FlowState> _inputStreamControll =
      BehaviorSubject<FlowState>();

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
