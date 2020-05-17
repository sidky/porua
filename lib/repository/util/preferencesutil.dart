import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {
  final Future<SharedPreferences> _preferences = SharedPreferences.getInstance();

  Future<void> setString(String prefix, String key, String value) async =>
      _setValue(prefix, key, value, (p, k, v) => p.setString(k, v));

  Future<String> getString(String prefix, String key) async =>
      _getValue(prefix, key, (pref, key) => pref.getString(key));

  Future<void> setInt(String prefix, String key, int value) async =>
      _setValue(prefix, key, value, (p, k, v) => p.setInt(k, v));

  Future<int> getInt(String prefix, String key) async =>
      _getValue(prefix, key, (pref, key) => pref.getInt(key));

  Future<void> setBoolean(String prefix, String key, bool value) async =>
      _setValue(prefix, key, value, (p, k, v) => p.setBool(k, v));

  Future<bool> getBool(String prefix, String key) async =>
      _getValue(prefix, key, (pref, key) => pref.getBool(key));

  Future<void> _setValue<T>(String prefix, String key, T value, void Function(SharedPreferences, String, T) setter) async {
    SharedPreferences preferences = await _preferences;
    setter(preferences, _key(prefix, key), value);
  }

  Future<T> _getValue<T>(String prefix, String key, T Function(SharedPreferences, String) getter) async {
    SharedPreferences preferences = await _preferences;
    return getter(preferences, _key(prefix, key));
  }

  String _key(String prefix, String key) => "$prefix:$key";
}