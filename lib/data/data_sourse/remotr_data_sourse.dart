import 'package:advanced_flutter/data/network/app_api.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/data/response/responses.dart';

abstract class RemoteDataSourse {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgetResponse> forget(ForgotRequest forgotRequest);
}

class RemoteDataSourseImpl extends RemoteDataSourse {
  final AppServiceClient appServiceClient;
  RemoteDataSourseImpl({
    required this.appServiceClient,
  });
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgetResponse> forget(ForgotRequest forgotRequest) async {
    return await appServiceClient.forgot(forgotRequest.email);
  }
}
