import 'package:get_it/get_it.dart';
import 'package:porua/repository/api/oldreader.dart';
import 'package:porua/repository/model/auth.dart';
import 'package:porua/repository/persistable/auth.dart';

class AuthRepository {
  final OldReaderAPI _api;
  Auth _currentAuth;

  Auth get currentAuth => _currentAuth;

  AuthRepository({OldReaderAPI api}): this._api = api ?? GetIt.I.get();

  Future<void> initialize() async {
    this._currentAuth = await AuthPreferencesExtension.read();
  }

  bool isAuthenticated() => _currentAuth != null;

  Future<bool> authenticate(String email, String password) async {
    this._currentAuth = await _api.authenticate(email, password);
    await this._currentAuth.persist();
    return true;
  }
}