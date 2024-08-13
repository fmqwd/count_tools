// 使用shared_preferences的工具类
import 'package:count_tools/utils/safe_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedUtils {
  static Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  /// 保存字符串
  static Future<bool> setString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(key, value);
  }

  /// 获取字符串
  static Future<String> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return safeString(prefs.getString(key));
  }

  /// 保存布尔
  static Future<bool> setBool(String key, bool value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setBool(key, value);
  }

  /// 获取布尔
  static Future<bool> getBool(String key) async {
    final SharedPreferences prefs = await _prefs;
    return safeBool(prefs.getBool(key));
  }

  /// 保存整数
  static Future<bool> setInt(String key, int value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setInt(key, value);
  }

  /// 获取整数
  static Future<int> getInt(String key) async {
    final SharedPreferences prefs = await _prefs;
    return safeInt(prefs.getInt(key));
  }
}
