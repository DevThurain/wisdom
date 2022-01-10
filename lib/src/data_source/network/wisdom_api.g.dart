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
