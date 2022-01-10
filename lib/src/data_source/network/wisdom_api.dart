import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wisdom/src/app_constants/app_api_route.dart';
import 'package:wisdom/src/data_models/response/response_register_vo.dart';
import 'package:wisdom/src/data_models/vos/app_version_vo.dart';
part 'wisdom_api.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class WisdomAPI {
  factory WisdomAPI(Dio dio) = _WisdomAPI;

  @GET("/check-version/wisdom-android")
  Future<AppVersionVo> checkAppVersion();

  @POST("/wisdom-user/register")
  Future<ResponseRegisterVO> registerUser(
     @Query("nickname") String nickname,
      @Query("code") String code, 
      @Query("device_id") String deviceId,
      @Query("password") String password
  );
}
