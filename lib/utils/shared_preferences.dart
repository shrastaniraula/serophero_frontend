import 'package:shared_preferences/shared_preferences.dart';

class SharedUtils {
  static const String _tokenKey = 'user_token';
  static const String _idKey = 'id_token';

  // Get saved token from shared preferences
  // static Future<String> getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_tokenKey) ?? '';
  // }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) ?? '';
  }

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<void> saveId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_idKey, id.toString());
  }

  static Future<String> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_idKey) ?? '';
  }

  // Clear saved token from shared preferences
  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
