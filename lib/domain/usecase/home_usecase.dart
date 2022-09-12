import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/domain/model/models.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class HomeUsecase implements BaseUseCase<void, HomeObject> {
  final Repository repository;

  HomeUsecase(this.repository);
  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return repository.getHomeData();
  }
}
