import 'dart:math';

import 'package:intl/intl.dart';

/// 生成唯一ID
String generateUniqueId() {
  // 获取当前时间戳（毫秒）
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  // 生成一个随机数（可选），可增加唯一性
  int randomNum = Random().nextInt(10000); // 生成0到9999的随机数

  // 将时间戳与随机数结合
  int uniqueId = timestamp + randomNum;

  return uniqueId.toString();
}

//获取当前日期，2024-01-01 格式
String getCurrentDate() => DateFormat('yyyy-MM-dd').format(DateTime.now());

//格式化时间-Date=>2024-01-01
String formatDate(DateTime dateTime) => DateFormat('yyyy-MM-dd').format(dateTime);
