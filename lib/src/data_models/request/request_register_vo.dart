class RequestRegisterVO {
  String nickname;
  String code;
  String deviceId;
  String password;

  RequestRegisterVO(
      {required this.nickname,
      required this.code,
      required this.deviceId,
      required this.password});
}
