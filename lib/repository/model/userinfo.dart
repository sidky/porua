class UserInfo {
  String userId;
  String userName;
  String userProfileId;
  String userEmail;
  bool isBloggerUser;
  DateTime signupTime;
  bool isMultiLoginEnabled;
  bool isPremium;

  UserInfo(this.userId, this.userName, this.userProfileId, this.userEmail, this.isBloggerUser, this.signupTime, this.isMultiLoginEnabled, this.isPremium);

  UserInfo.fromJson(Map<String, dynamic> data) {
    this.userId = data["userId"];
    this.userName = data["userName"];
    this.userProfileId = data["userProfileId"];
    this.userEmail = data["userEmail"];
    this.isBloggerUser = data["isBloggerUser"];
    this.signupTime = DateTime.fromMillisecondsSinceEpoch(data["signupTimeSec"] * 1000);
    this.isMultiLoginEnabled = data["isMultiLoginEnabled"];
    this.isPremium = data["isPremium"];
  }

  @override
  String toString() {
    return '''{
      'userId': $userId,
      'userName': $userName,
      'userProfileId': $userProfileId,
      'userEmail': $userEmail,
      'isBloggerUser': $isBloggerUser,
      'signupTime': $signupTime,
      'isMultiLoginEnabled': $isMultiLoginEnabled,
      'isPremium': $isPremium
    }''';
  }
}