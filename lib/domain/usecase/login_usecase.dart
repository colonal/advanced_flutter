import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
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
