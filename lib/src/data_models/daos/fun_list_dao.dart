/// funList : [{"id":1,"profileUrl":"https://joinposter.com/i/site/blog/some_unique_bar_promotion_ideas_large.jpg","userNickName":"Han Gyi","userKey":"U-1233234","userId":1,"content":"“You know, we really should quit meeting like this,” Mike said, shaking his head.“Heyya, Mike,” I said. “Mike, Ben. Ben, Mike.”“Nice to meet you,” Ben said, a bit confused.“Hello, Ben,” Mike said. “Sandy and I have met a few times. I really thought she would make it through the night this year without having to call Fire and Rescue. You were so close, Sandy!”“I know. I let my guard down,” Sandy said, pouting a bit.“What would New Years Eve be without a call from Sandy?” Mike asked his partner, Gerry....","commentCount":"12","postUploadedAt":"12 Hrs Ago"},{"id":2,"profileUrl":"https://joinposter.com/i/site/blog/some_unique_bar_promotion_ideas_large.jpg","userNickName":"Han Gyi","userKey":"U-8800aAw","userId":1,"content":"“Let him through!” Zac’s new friend bellowed, standing up and bumping his head on the baggage locker above him. They’d just touched down and the passengers were desperate to get off the plane.“Come ON,” hissed Luke, shoving Zac into the aisle. “Move!” he added to the man who’d snored through the whole flight from Istanbul.Passengers in the front seats were stretching, glancing Zac’s way in annoyance. He looked away, embarrassed. He’d only started talking to Luke later in the flight when violent air turbulence over...","commentCount":"12","postUploadedAt":"12 Hrs Ago"},{"id":3,"profileUrl":"https://joinposter.com/i/site/blog/some_unique_bar_promotion_ideas_large.jpg","userNickName":"Han Gyi","userKey":"U-99UU&HI","userId":3,"content":"1-800-Spiritual-Specialists Laura Pamenter There is no weather in the phantom realm. Just a gust of wind of every time a new ghost transports to our world, leaving behind their first home.  The banshee-like howl of the wind woke me today. It tore through my bedroom window like a hurricane, sharp and ferocious. They say sleep isn’t necessary f...","commentCount":"12","postUploadedAt":"12 Hrs Ago"},{"id":4,"profileUrl":"https://joinposter.com/i/site/blog/some_unique_bar_promotion_ideas_large.jpg","userNickName":"Han Gyi","userKey":"U-99UU&HI","userId":3,"content":"1-800-Spiritual-Specialists Laura Pamenter There is no weather in the phantom realm. Just a gust of wind of every time a new ghost transports to our world, leaving behind their first home.  The banshee-like howl of the wind woke me today. It tore through my bedroom window like a hurricane, sharp and ferocious. They say sleep isn’t necessary f...","commentCount":"12","postUploadedAt":"12 Hrs Ago"},{"id":5,"profileUrl":"https://joinposter.com/i/site/blog/some_unique_bar_promotion_ideas_large.jpg","userNickName":"Han Gyi","userKey":"U-99UU&HI","userId":3,"content":"1-800-Spiritual-Specialists Laura Pamenter There is no weather in the phantom realm. Just a gust of wind of every time a new ghost transports to our world, leaving behind their first home.  The banshee-like howl of the wind woke me today. It tore through my bedroom window like a hurricane, sharp and ferocious. They say sleep isn’t necessary f...","commentCount":"12","postUploadedAt":"12 Hrs Ago"},{"id":6,"profileUrl":"https://joinposter.com/i/site/blog/some_unique_bar_promotion_ideas_large.jpg","userNickName":"Han Gyi","userKey":"U-99UU&HI","userId":3,"content":"1-800-Spiritual-Specialists Laura Pamenter There is no weather in the phantom realm. Just a gust of wind of every time a new ghost transports to our world, leaving behind their first home.  The banshee-like howl of the wind woke me today. It tore through my bedroom window like a hurricane, sharp and ferocious. They say sleep isn’t necessary f...","commentCount":"12","postUploadedAt":"12 Hrs Ago"}]

class FunListDao {
  List<FunItem>? _funList;

  List<FunItem>? get funList => _funList;

  FunListDao({
      List<FunItem>? funList}){
    _funList = funList;
}

  FunListDao.fromJson(dynamic json) {
    if (json['funList'] != null) {
      _funList = [];
      json['funList'].forEach((v) {
        _funList?.add(FunItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_funList != null) {
      map['funList'] = _funList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// profileUrl : "https://joinposter.com/i/site/blog/some_unique_bar_promotion_ideas_large.jpg"
/// userNickName : "Han Gyi"
/// userKey : "U-1233234"
/// userId : 1
/// content : "“You know, we really should quit meeting like this,” Mike said, shaking his head.“Heyya, Mike,” I said. “Mike, Ben. Ben, Mike.”“Nice to meet you,” Ben said, a bit confused.“Hello, Ben,” Mike said. “Sandy and I have met a few times. I really thought she would make it through the night this year without having to call Fire and Rescue. You were so close, Sandy!”“I know. I let my guard down,” Sandy said, pouting a bit.“What would New Years Eve be without a call from Sandy?” Mike asked his partner, Gerry...."
/// commentCount : "12"
/// postUploadedAt : "12 Hrs Ago"

class FunItem {
  int? _id;
  String? _profileUrl;
  String? _userNickName;
  String? _userKey;
  int? _userId;
  String? _content;
  String? _commentCount;
  String? _postUploadedAt;

  int? get id => _id;
  String? get profileUrl => _profileUrl;
  String? get userNickName => "${DateTime.now().microsecond} $_userNickName";
  String? get userKey => _userKey;
  int? get userId => _userId;
  String? get content => _content;
  String? get commentCount => _commentCount;
  String? get postUploadedAt => _postUploadedAt;

  FunItem({
      int? id, 
      String? profileUrl, 
      String? userNickName, 
      String? userKey, 
      int? userId, 
      String? content, 
      String? commentCount, 
      String? postUploadedAt}){
    _id = id;
    _profileUrl = profileUrl;
    _userNickName = userNickName;
    _userKey = userKey;
    _userId = userId;
    _content = content;
    _commentCount = commentCount;
    _postUploadedAt = postUploadedAt;
}

  FunItem.fromJson(dynamic json) {
    _id = json['id'];
    _profileUrl = json['profileUrl'];
    _userNickName = json['userNickName'];
    _userKey = json['userKey'];
    _userId = json['userId'];
    _content = json['content'];
    _commentCount = json['commentCount'];
    _postUploadedAt = json['postUploadedAt'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['profileUrl'] = _profileUrl;
    map['userNickName'] = _userNickName;
    map['userKey'] = _userKey;
    map['userId'] = _userId;
    map['content'] = _content;
    map['commentCount'] = _commentCount;
    map['postUploadedAt'] = _postUploadedAt;
    return map;
  }

}