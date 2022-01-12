import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wisdom/src/app_constants/app_api_route.dart';
import 'package:wisdom/src/data_models/response/response_login_vo.dart';
import 'package:wisdom/src/data_models/response/response_register_vo.dart';
import 'package:wisdom/src/data_models/vos/app_version_vo.dart';
import 'package:wisdom/src/data_models/vos/fun_detail_vo.dart';
import 'package:wisdom/src/data_models/vos/post_list_vo.dart';

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
      @Query("password") String password);

  @POST("/wisdom-user/login")
  Future<ResponseLoginVO> loginUser(
    @Query("nickname") String nickname,
    @Query("password") String password,
  );

  @GET("/wisdom/posts")
  Future<PostListVo> getFunList();

  @GET("/wisdom/post/{postId}")
  Future<FunDetailVo> getFunDetail(
    @Path("postId") int postId,
    @Query("detail") bool isDetail,
  );
}
