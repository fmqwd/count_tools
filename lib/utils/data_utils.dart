import 'dart:math';

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
String getCurrentDate() {
  DateTime now = DateTime.now();
  String year = now.year.toString();
  String month = now.month.toString().padLeft(2, '0');
  String day = now.day.toString().padLeft(2, '0');
  return '$year-$month-$day';
}
