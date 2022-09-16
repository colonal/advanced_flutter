import '../../data/network/failure.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
import 'package:dartz/dartz.dart';

class HomeUsecase implements BaseUseCase<void, HomeObject> {
  final Repository repository;

  HomeUsecase(this.repository);
  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return repository.getHomeData();
  }
}
