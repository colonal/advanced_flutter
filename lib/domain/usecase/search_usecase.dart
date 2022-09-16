import '../../data/network/requests.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../model/models.dart';
import 'base_usecase.dart';

import '../repository/repository.dart';

class SearchUsecase extends BaseUseCase<SearchUsecaseInput, SearchObject> {
  final Repository repository;
  SearchUsecase({
    required this.repository,
  });
  @override
  Future<Either<Failure, SearchObject>> execute(
      SearchUsecaseInput input) async {
    return repository.getSearch(SearchRequst(search: input.search));
  }
}

class SearchUsecaseInput {
  final String search;

  SearchUsecaseInput({required this.search});
}
