// ignore_for_file: no_leading_underscores_for_local_identifiers, constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:advanced_flutter/app/app_preferences.dart';

import '../../app/constants.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "langauge";

class DioFactory {
  final AppsPreferences appsPreferences;
  DioFactory({
    required this.appsPreferences,
  });
  Future<Dio> getDio() async {
    Dio dio = Dio();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constants.token,
      DEFAULT_LANGUAGE: await appsPreferences.getAppLanguage(),
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: Constants.apiItmeOut,
      sendTimeout: Constants.apiItmeOut,
    );

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
