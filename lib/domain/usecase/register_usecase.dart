import 'package:dartz/dartz.dart';

import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/domain/model/models.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/base_usecase.dart';

class RegisterUsecase
    implements BaseUseCase<RegisterUsecaseInput, Authentication> {
  final Repository repository;

  RegisterUsecase(this.repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUsecaseInput input) async {
    return repository.register(
      RegisterRequest(
        email: input.email,
        password: input.password,
        userName: input.userName,
        countryMobileCode: input.countryMobileCode,
        mobileNmber: input.mobileNmber,
        profilePicture: input.profilePicture,
      ),
    );
  }
}

class RegisterUsecaseInput {
  final String email;
  final String password;
  final String userName;
  final String countryMobileCode;
  final String mobileNmber;
  final String profilePicture;
  RegisterUsecaseInput({
    required this.email,
    required this.password,
    required this.userName,
    required this.countryMobileCode,
    required this.mobileNmber,
    required this.profilePicture,
  });
}
