import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/data/response/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );

  @POST("/customers/forgot")
  Future<ForgetResponse> forgot(
    @Field("email") String email,
  );

  @POST("/customer/register")
  Future<AuthenticationResponse> register(
    @Field("email") String email,
    @Field("password") String password,
    @Field("user_name") String userName,
    @Field("country_mobile_code") String countryMobileCode,
    @Field("mobile_number") String mobileNmber,
    @Field("profile_picture") String profilePicture,
  );

  @GET("/home")
  Future<HomeResponse> getHomeData();

  @GET("/storeDetails/{uid}")
  Future<StoreDetailsResponse> getStoreDetails(
    @Path() String uid,
  );

  @GET("/notification")
  Future<NotificationResponse> getNotification();
}
