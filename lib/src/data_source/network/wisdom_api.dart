
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wisdom/src/app_constants/app_api_route.dart';
import 'package:wisdom/src/data_models/vos/app_version_vo.dart';
part 'wisdom_api.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class WisdomAPI {
  factory WisdomAPI(Dio dio) = _WisdomAPI;

  @GET("/check-version/wisdom-android")
  Future<AppVersionVo> checkAppVersion();

}