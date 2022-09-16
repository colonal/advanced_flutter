import 'dart:async';

import '../../../domain/usecase/forgot_usecase.dart';
import '../../base/baseviewmodel.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class ForgetViewModel extends BaseViewModel
    with ForgotViewModelInputs, ForgetViewModelOutputs {
  ForgetViewModel(this._forgotUsecase);

  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var forgotObject = ForgetObject("");

  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  final ForgotUsecase _forgotUsecase;
  @override
  forget() async {
    inputState.add(
        ForgotState(stateRendererType: StateRendererType.popupLoadingStat));
    (await _forgotUsecase.execute(ForgotUsecaseInput(forgotObject.password)))
        .fold((failure) {
      // left -> failure
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.popupErrorstate,
          message: failure.message));
    }, (data) {
      // right -> data (success)
      inputState.add(ShowInfoState(
          stateRendererType: StateRendererType.fullScreenInfo,
          message: data.password));

      // //  content
      //   inputState.add(ContentState());

      //   // Navigator to main screen
      //   isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  setPassword(String password) {
    print(password);
    inputPassword.add(password);
    forgotObject = forgotObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isPasswordValid(forgotObject.password);
  }

  @override
  void dispose() {
    super.dispose();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
  }
}

abstract class ForgotViewModelInputs {
  setPassword(String password);

  forget();

  Sink get inputPassword;

  Sink get inputAreAllInputsValid;
}

abstract class ForgetViewModelOutputs {
  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outAreAllInputsValid;
}
