import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
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
