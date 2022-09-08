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
