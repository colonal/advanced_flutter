import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/domain/model/models.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class ForgotUsecase
    implements BaseUseCase<ForgotUsecaseInput, ForgotAuthentication> {
  final Repository repository;

  ForgotUsecase(this.repository);
  @override
  Future<Either<Failure, ForgotAuthentication>> execute(
      ForgotUsecaseInput input) {
    print("input.password: ${input.password}");
    return repository.forgot(ForgotRequest(email: input.password));
  }
}

class ForgotUsecaseInput {
  String password;

  ForgotUsecaseInput(this.password);
}
