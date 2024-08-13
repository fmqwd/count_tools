//首页设置工具，包括从sharedpreferences中获取设置，保存设置，更新设置
//获取的内容包括主题颜色等
import 'package:count_tools/utils/shared_utils.dart';
import 'package:flutter/material.dart';

class SettingUtils {
  static Future<MaterialColor> getThemeColor() async {
    String themeColor = await SharedUtils.getString("themeColor");
    switch (themeColor) {
      case "red":
        return Colors.red;
      case "pink":
        return Colors.pink;
      case "purple":
        return Colors.purple;
      case "deepPurple":
        return Colors.deepPurple;
      case "indigo":
        return Colors.indigo;
      case "blue":
        return Colors.blue;
      case "lightBlue":
        return Colors.lightBlue;
      case "cyan":
        return Colors.cyan;
      case "teal":
        return Colors.teal;
      case "green":
        return Colors.green;
      case "lightGreen":
        return Colors.lightGreen;
      case "lime":
        return Colors.lime;
      case "yellow":
        return Colors.yellow;
      case "amber":
        return Colors.amber;
      case "orange":
        return Colors.orange;
      case "deepOrange":
        return Colors.deepOrange;
      case "brown":
        return Colors.brown;
      case "grey":
        return Colors.grey;
      case "blueGrey":
        return Colors.blueGrey;
      default:
        return Colors.red;
    }
  }
}