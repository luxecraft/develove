import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<dynamic> readFromSharedPreference(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(key)) {
      return sharedPreferences.get(key);
    } else {
      return null;
    }
  }

  static Future<bool> writeToSharedPreference(String key, dynamic data) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return await sharedPreferences.setString(key, data);
  }

  static Future<void> removeFromSharedPreference(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }
}
