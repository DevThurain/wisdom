const List<String> profileAssetsUrlList = [
  "assets/images/ant.png",
  "assets/images/ic_age_bulk.png",
  "assets/images/ice_ace_sid.png",
  "assets/images/jerry.png",
  "assets/images/larva_red.png",
  "assets/images/minion.png",
  "assets/images/slooth.png",
  "assets/images/purple_minion.png",
  "assets/images/tom.png",
  "assets/images/snow_man.png",
];

class TempProfileGenerator {
  static String getTempProfileUrl(int? userId) {
    try {
      return profileAssetsUrlList[int.parse("$userId".split("").last)];
    } catch (e) {
      return profileAssetsUrlList[8];
    }
  }
}
