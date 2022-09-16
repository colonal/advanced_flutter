import '../../data/network/failure.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
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
