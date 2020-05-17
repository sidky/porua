import 'dart:io';
import 'dart:convert';

import 'package:porua/repository/model/apierror.dart';
import 'package:porua/repository/model/auth.dart';
import 'package:http/http.dart' as http;
import 'package:porua/repository/model/feeditemresponse.dart';
import 'package:porua/repository/model/userinfo.dart';

const String _AUTHORIZATION_HEADER = "Authorization";

String _authorizationHeaderValue(String token) {
  return "GoogleLogin auth=$token";
}

class OldReaderAPI {
  Future<Auth> authenticate(String email, String password) async {
    var response = await http.post("https://theoldreader.com/accounts/ClientLogin",
      body: {
        "client": "porua",
        "accountType": "HOSTED_OR_GOOGLE",
        "service": "reader",
        "Email": email,
        "Passwd": password
      });

    if (response.statusCode == 200) {
      return _parseAuthBody(response.body);
    } else if (response.statusCode == 403) {
      throw ApiError(403, "Invalid email or password");
    } else {
      throw ApiError(response.statusCode, "Server error");
    }
  }

  Future<UserInfo> profile(String authToken) async {
    var response = await http.get("https://theoldreader.com/reader/api/0/user-info?output=json",
      headers: {
        _AUTHORIZATION_HEADER: _authorizationHeaderValue(authToken)
      });

      if (response.statusCode == 200) {
        return _parseUserInfo(response.body);
      } else {
        throw ApiError(response.statusCode, response.reasonPhrase);
      }
  }

  Future<FeedItemResponse> feedStream(String authToken, {int continuation}) async {
    String url;

    if (continuation == null) {
      url = "https://theoldreader.com/reader/api/0/stream/contents?output=json";
    } else {
      url = "https://theoldreader.com/reader/api/0/stream/contents?output=json&c=$continuation";
    }
    
    var response = await http.get(url,
      headers:  {
        _AUTHORIZATION_HEADER: _authorizationHeaderValue(authToken)
      });

    if (response.statusCode == 200) {
      return _parseFeedItemResponse(response.body);
    } else {
      throw ApiError(response.statusCode, response.reasonPhrase);
    }
  }

  Auth _parseAuthBody(String response) {
    Auth auth;
    DateTime authTime = DateTime.now();

    response.split("\n").forEach((element) { 
      List<String> parts = element.split("=");

      if (parts.length != 2) {
        print('Invalid line format: $element');
      } else {
        if (parts[0] == "Auth") {
          auth = new Auth(parts[1], authTime);
        }
      }
    });
    return auth;
  }

  UserInfo _parseUserInfo(String response) {
    var parsed = json.decode(response);
    return UserInfo.fromJson(parsed);
  }

  FeedItemResponse _parseFeedItemResponse(String response) {
    var parsed = json.decode(response);
    return FeedItemResponse.fromJson(parsed);
  }
}