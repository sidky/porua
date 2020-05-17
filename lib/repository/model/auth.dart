import 'package:get_it/get_it.dart';
import 'package:porua/repository/util/preferencesutil.dart';

class Auth {
  final String authId;
  final DateTime authenticationTime;

  Auth(this.authId, this.authenticationTime);

  @override
  String toString() {
    return "{'authId': $authId, 'authenticationTime': $authenticationTime}";
  }
}