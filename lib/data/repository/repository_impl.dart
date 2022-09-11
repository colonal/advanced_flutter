import 'package:advanced_flutter/data/network/error_handler.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:dartz/dartz.dart';

import 'package:advanced_flutter/data/data_sourse/remotr_data_sourse.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/domain/model/models.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';

import '../mapper/mapper.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSourse remoteDataSourse;
  final NetworckInfo networckInfo;
  RepositoryImpl({
    required this.remoteDataSourse,
    required this.networckInfo,
  });
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await networckInfo.isConnected) {
      try {
        final response = await remoteDataSourse.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(ApiInternalStatus.FALURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }

    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  @override
  Future<Either<Failure, ForgotAuthentication>> forgot(
      ForgotRequest forgotRequest) async {
    if (await networckInfo.isConnected) {
      try {
        final response = await remoteDataSourse.forget(forgotRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(ApiInternalStatus.FALURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }

    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await networckInfo.isConnected) {
      try {
        final response = await remoteDataSourse.register(registerRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(ApiInternalStatus.FALURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }

    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }
}
