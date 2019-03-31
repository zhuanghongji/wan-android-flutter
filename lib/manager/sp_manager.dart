import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences 常量 (Key)
class SpConstant {

  static const username = 'username';
  static const password = 'password';
  static const email = 'email';
  static const avatarUrl = 'avatarUrl';

  /// 暂时不用 sp 来存储 cookie
  static const cookies = 'cookies';
}

/// SharedPreferences 管理类
/// 
/// 主要是在 [SharedPreferences] 上面封装了一层
class SpManager {

  // MARK: Gets 

  static Future<bool> getBool(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<double> getDouble(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  static Future<int> getInt(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<String> getString(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<List<String>> getStringList(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }



  // MARK: Sets 

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
  }

  static Future<bool> setDouble(String key, double value) async {
    var prefs = await SharedPreferences.getInstance();
    return await prefs.setDouble(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    var prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(key, value);
  }


  // MARK: Else

  static Future<bool> remove(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }

  static Future<bool> clear() async {
    var prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  static Future<Set<String>> getKeys() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getKeys();
  }
}