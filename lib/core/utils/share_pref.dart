import 'package:shared_preferences/shared_preferences.dart';

enum SharePrefType {
  BOOL,
  DOUBLE,
  INT,
  STRING,
  OBJECT,
}

class SharePref {

  static dynamic getSharePref(String key, SharePrefType type) async {
    final prefs = await SharedPreferences.getInstance();
    switch (type) {
      case SharePrefType.BOOL:
        return prefs.getBool(key);
      case SharePrefType.STRING:
        return prefs.getString(key);
      case SharePrefType.DOUBLE:
        return prefs.getDouble(key);
      case SharePrefType.INT:
        return prefs.getInt(key);
      // case SharePrefType.OBJECT:
      //   return prefs.getString(key);
      default:
        return null;
    }
  }

  static put(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    }
  }
}
