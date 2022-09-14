import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/domain/model/models.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class NotificationUsecase implements BaseUseCase<void, NotificationObject> {
  final Repository repository;
  NotificationUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, NotificationObject>> execute(void input) async {
    return repository.getNotification();
  }
}
