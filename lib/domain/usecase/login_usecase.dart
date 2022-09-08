import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/domain/model/models.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase implements BaseUseCase<LoginUsecaseInput, Authentication> {
  final Repository repository;

  LoginUsecase(this.repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUsecaseInput input) async {
    return repository.login(
      LoginRequest(email: input.email, password: input.password),
    );
  }
}

class LoginUsecaseInput {
  String email;
  String password;

  LoginUsecaseInput(this.email, this.password);
}
