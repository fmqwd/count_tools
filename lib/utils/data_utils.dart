import 'dart:math';

//根据时间戳生成id
import 'dart:math';

String generateUniqueId() {
  // 获取当前时间戳（毫秒）
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  // 生成一个随机数（可选），可增加唯一性
  int randomNum = Random().nextInt(10000); // 生成0到9999的随机数

  // 将时间戳与随机数结合
  int uniqueId = timestamp + randomNum;

  return uniqueId.toString();
}
