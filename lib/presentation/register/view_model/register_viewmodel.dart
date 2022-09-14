import 'dart:async';
import 'dart:io';

import 'package:advanced_flutter/app/functions.dart';
import 'package:advanced_flutter/domain/usecase/register_usecase.dart';
import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:advanced_flutter/presentation/common/freezed_data_classes.dart';
import 'package:advanced_flutter/presentation/resources/string_manager.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final RegisterUsecase _registerUsecase;
  RegisterViewModel(this._registerUsecase);

  RegisterObject registerObject = RegisterObject("", "", "", "", "", "");

  StreamController usernameStreamController =
      StreamController<String>.broadcast();
  StreamController mobileNumberStreamController =
      StreamController<String>.broadcast();
  StreamController emailStreamController = StreamController<String>.broadcast();
  StreamController passwordStreamController =
      StreamController<String>.broadcast();
  StreamController profilePictureStreamController =
      StreamController<File>.broadcast();
  StreamController areAllInputValidStreamController =
      StreamController<void>.broadcast();

  StreamController isUserRegisterInSuccessfullyStreamController =
      StreamController<bool>();

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    usernameStreamController.close();
    mobileNumberStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    profilePictureStreamController.close();
    areAllInputValidStreamController.close();
    isUserRegisterInSuccessfullyStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputMobileNumber => mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => profilePictureStreamController.sink;

  @override
  Sink get inputUserName => usernameStreamController.sink;

  @override
  Sink get inputAllInputsValid => areAllInputValidStreamController.sink;

  @override
  Stream<bool> get outputIsUserNameValid => usernameStreamController.stream
      .map((userName) => _userNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName =>
      outputIsUserNameValid.map((isUserName) {
        return isUserName ? null : AppStrings.userNameInvalid.tr();
      });

  @override
  Stream<bool> get outputIsEmailValid =>
      emailStreamController.stream.map((email) => isEmailValid(email));
  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid.map((isEmail) {
        return isEmail ? null : AppStrings.invalidEmail.tr();
      });

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      mobileNumberStreamController.stream
          .map((mobilNumber) => _isMobileNumberValid(mobilNumber));
  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumberValid.map((isMobilNumber) =>
          isMobilNumber ? null : AppStrings.mobileNumberInvalid.tr());

  @override
  Stream<bool> get outputIsPasswordValid => passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isPassword) => isPassword ? null : AppStrings.passwordInvalid.tr());

  @override
  Stream<File> get outputIsProfilePictureValid =>
      profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputAllInputsValid =>
      areAllInputValidStreamController.stream.map((c) => _areAllInputValid());

  // private function
  bool _userNameValid(String userName) {
    return userName.length >= 3;
  }

  bool _isMobileNumberValid(String mobilNumber) {
    return mobilNumber.length >= 9;
  }

  bool _isPasswordValid(password) {
    return password.length >= 6;
  }

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingStat));
    (await _registerUsecase.execute(
      RegisterUsecaseInput(
        email: registerObject.email,
        password: registerObject.password,
        userName: registerObject.userName,
        countryMobileCode: registerObject.countryMobileCode,
        mobileNmber: registerObject.mobileNmber,
        profilePicture: registerObject.profilePicture,
      ),
    ))
        .fold(
            (failure) => {
                  // left -> failure
                  inputState.add(ErrorState(
                      stateRendererType: StateRendererType.popupErrorstate,
                      message: failure.message)),
                }, (data) {
      // right -> data (success)

      //  content
      inputState.add(ContentState());

      // Navigator to main screen
      isUserRegisterInSuccessfullyStreamController.add(true);
    });
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_userNameValid(userName)) {
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

  @override
  void setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    } else {
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      registerObject = registerObject.copyWith(mobileNmber: mobileNumber);
    } else {
      registerObject = registerObject.copyWith(mobileNmber: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  bool _areAllInputValid() {
    return registerObject.countryMobileCode.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty &&
        registerObject.mobileNmber.isNotEmpty &&
        registerObject.userName.isNotEmpty;
  }

  validate() {
    inputAllInputsValid.add(true);
  }
}

abstract class RegisterViewModelInput {
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;

  Sink get inputAllInputsValid;

  register();

  setUserName(String userName);
  setMobileNumber(String mobileNumber);
  setEmail(String email);
  setPassword(String password);
  setCountryCode(String countryCode);
  setProfilePicture(File profilePicture);
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<File> get outputIsProfilePictureValid;

  Stream<bool> get outputAllInputsValid;
}
