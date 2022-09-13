import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class StoreDetailsUsecase
    implements BaseUseCase<StoreDetailsUsecaseInput, StoreDetails> {
  final Repository repository;

  StoreDetailsUsecase(this.repository);
  @override
  Future<Either<Failure, StoreDetails>> execute(
      StoreDetailsUsecaseInput input) async {
    return repository.getStoreDetails(StoreDetailsRequst(input.id));
  }
}

class StoreDetailsUsecaseInput {
  String id;

  StoreDetailsUsecaseInput(this.id);
}
