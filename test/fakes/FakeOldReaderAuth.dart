import 'package:porua/repository/api/oldreader.dart';
import 'package:porua/repository/model/auth.dart';

class FakeOldReaderAuth extends OldReaderAPI {
  String _authToken;

  Future<Auth> authenticate(String email, String password) async {
    if (_authToken != null) {
      return new Auth(_authToken, DateTime.now());
    } else {
      throw Exception("Invalid auth");
    }
  }

  void setAuthToken(String token) {
    this._authToken = token;
  }

  void resetToken() {
    this._authToken = null;
  }
}