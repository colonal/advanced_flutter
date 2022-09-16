class LoginRequest {
  String email;
  String password;
  LoginRequest({
    required this.email,
    required this.password,
  });
}

class ForgotRequest {
  final String email;
  ForgotRequest({
    required this.email,
  });
}

class RegisterRequest {
  final String email;
  final String password;
  final String userName;
  final String countryMobileCode;
  final String mobileNmber;
  final String profilePicture;
  RegisterRequest({
    required this.email,
    required this.password,
    required this.userName,
    required this.countryMobileCode,
    required this.mobileNmber,
    required this.profilePicture,
  });
}

class StoreDetailsRequst {
  final String id;

  StoreDetailsRequst(this.id);
}

class SearchRequst {
  final String search;
  SearchRequst({
    required this.search,
  });
}
