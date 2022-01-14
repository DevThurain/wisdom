// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wisdom_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _WisdomAPI implements WisdomAPI {
  _WisdomAPI(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://128.199.128.58/mobile';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AppVersionVo> checkAppVersion() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AppVersionVo>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/check-version/wisdom-android',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AppVersionVo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseRegisterVO> registerUser(
      nickname, code, deviceId, password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'nickname': nickname,
      r'code': code,
      r'device_id': deviceId,
      r'password': password
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseRegisterVO>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wisdom-user/register',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseRegisterVO.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseLoginVO> loginUser(nickname, password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'nickname': nickname,
      r'password': password
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseLoginVO>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wisdom-user/login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseLoginVO.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseSuccessVO> logoutUser() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseSuccessVO>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wisdom-user/logout',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseSuccessVO.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostListVo> getFunList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostListVo>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wisdom/posts',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostListVo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FunDetailVo> getFunDetail(postId, isDetail) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'detail': isDetail};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FunDetailVo>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wisdom/post/${postId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FunDetailVo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommentResponseVo> commentFunDetail(postId, commentText) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'comment': commentText};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommentResponseVo>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wisdom/comment/${postId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommentResponseVo.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
