import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 解析字符串颜色
/// 支持格式：
///   - #FF000000、#FF0000、#FFF
///   - rgba(255, 255, 255, 1.0)
///   - rgb(255, 255, 255)
Color parseColor(
  String color, {
  Color defaultValue = Colors.transparent,
  double? alpha,
}) {
  if (color.isEmpty) return defaultValue;
  Color r = Colors.transparent;
  if (color.startsWith("#")) {
    /// Hexadecimal color
    if (color.length == 4) {
      var v1 = color.substring(1, 2);
      var v2 = color.substring(2, 3);
      var v3 = color.substring(3, 4);
      color = "#$v1$v1$v2$v2$v3$v3";
      return Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000);
    } else if (color.length == 7) {
      return Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000);
    } else if (color.length == 9) {
      return Color(int.parse(color.substring(1, 9), radix: 16) + 0x00000000);
    }
  } else if (color.toLowerCase().startsWith("rgba")) {
    /// rgba
    color = color.substring(5, color.length - 1);
    List<String> split = color.replaceAll(" ", "").split(",");
//    print('rgba.length-${split.length}');
    if (split.length == 3) {
      split.add("1.0");
    }
//    print('rgba-$split');
    r = Color.fromARGB(
      max(
          0,
          min(int.parse((double.parse(split[3]) * 255.0).toInt().toString()),
              255)),
      max(0, min(int.parse(split[0]), 255)),
      max(0, min(int.parse(split[1]), 255)),
      max(0, min(int.parse(split[2]), 255)),
    );
  } else if (color.toLowerCase().startsWith("rgb")) {
    /// rgb
    color = color.substring(4, color.length - 1);
    var split = color.replaceAll(" ", "").split(",");
    r = Color.fromARGB(
      255,
      max(0, min(int.parse(split[0]), 255)),
      max(0, min(int.parse(split[1]), 255)),
      max(0, min(int.parse(split[2]), 255)),
    );
  }
  if (alpha != null) {
    r = r.withOpacity(min(alpha, 1.0));
  }
  return r;
}

String intColorToHex(Color color) {
  return '#${color.value.toRadixString(16).substring(2, 8)}'; // 提取 rgb 部分
}

//根据颜色亮度返回对应的文字颜色（黑或白）
Color getTextColor(Color color) =>
    ((color.red * 299 + color.green * 587 + color.blue * 114) / 1000).round() >
            128
        ? Colors.black
        : Colors.white;

//设置屏幕方向
void setScreenOrientation(bool isLandscape) {
  WidgetsFlutterBinding.ensureInitialized();
  if (isLandscape) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  } else {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}

