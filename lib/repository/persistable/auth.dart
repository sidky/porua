import 'package:get_it/get_it.dart';
import 'package:porua/repository/model/auth.dart';
import 'package:porua/repository/util/preferencesutil.dart';

const String _prefix = "com.github.sidky.porua.auth";

extension AuthPreferencesExtension on Auth {

  Future<void> persist() async {
    PreferencesUtil util = GetIt.I.get();
    await util.setString(_prefix, "authId", this.authId);
    await util.setInt(_prefix, "authenticationTime", this.authenticationTime.millisecondsSinceEpoch);
  }

  static Future<Auth> read() async {
    PreferencesUtil util = GetIt.I.get();
    String authId = await util.getString(_prefix, "authId");
    int authTimeMillis = await util.getInt(_prefix, "authenticationTime");
    if (authId == null || authTimeMillis == null) return null;
    DateTime authenticationTime = DateTime.fromMillisecondsSinceEpoch(authTimeMillis);
    return Auth(authId, authenticationTime);
  }
}