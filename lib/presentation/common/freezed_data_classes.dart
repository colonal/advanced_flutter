import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class ForgetObject with _$ForgetObject {
  factory ForgetObject(String password) = _ForgetObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
    String email,
    String password,
    String userName,
    String countryMobileCode,
    String mobileNmber,
    String profilePicture,
  ) = _RegisterObject;
}

@freezed
class SearchViewmodelObject with _$SearchViewmodelObject {
  factory SearchViewmodelObject(String seach) = _SearchViewmodelObjectObject;
}
