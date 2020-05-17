import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:porua/repository/model/userinfo.dart';

void main() {
  test("Test parsing UserInfo is working", () {
    const String body = ''' {
      "userId": "30abcdefghjo",
      "userName": "Manzurur Rahman Khan",
      "userProfileId": "wgwe;gqfqfqwfqwwn;",
      "userEmail": "a@b.com",
      "isBloggerUser": false,
      "signupTimeSec": 1589419694,
      "isMultiLoginEnabled": false,
      "isPremium": false
    }
    ''';

    var parsed = json.decode(body);
    var userInfo = UserInfo.fromJson(parsed);

    expect(userInfo.userId, equals("30abcdefghjo"));
    expect(userInfo.userName, equals("Manzurur Rahman Khan"));
    expect(userInfo.userProfileId, equals("wgwe;gqfqfqwfqwwn;"));
    expect(userInfo.userEmail, equals("a@b.com"));
    expect(userInfo.isPremium, equals(false));
    expect(userInfo.signupTime, equals(DateTime.fromMillisecondsSinceEpoch(1589419694 * 1000)));
    expect(userInfo.isMultiLoginEnabled, equals(false));
    expect(userInfo.isPremium, equals(false));
  });
}