import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/domain/model/models.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, ForgotAuthentication>> forgot(
      ForgotRequest forgotRequest);
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, HomeObject>> getHomeData();
  Future<Either<Failure, StoreDetails>> getStoreDetails(
      StoreDetailsRequst storeDetailsRequst);

  Future<Either<Failure, NotificationObject>> getNotification();
  Future<Either<Failure, SearchObject>> getSearch(SearchRequst searchRequst);
}
