import 'package:flutter/foundation.dart';

class Log {
  static void d(String tag, String msg) {
    if (kDebugMode) {
      print('[$tag] $msg');
    }
  }
  static void i(String tag, String msg) {
    if (kDebugMode) {
      print('[$tag] $msg');
    }
  }
  static void e(String tag, String msg) {
    if (kDebugMode) {
      print('[$tag] $msg');
    }
  }
  static void w(String tag, String msg) {
    if (kDebugMode) {
      print('[$tag] $msg');
    }
  }
  static void v(String tag, String msg) {
    if (kDebugMode) {
      print('[$tag] $msg');
    }
  }
}
