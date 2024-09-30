import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'log.dart';

// 路由相关的工具类
class RouteUtils {

  static void push(
    BuildContext context,
    Widget page, {
    PageRouteBuilder? pageRouteBuilder, // 自定义构建器
    bool replace = false, // 是否替换当前页面
    bool removeUntil = false, // 是否移除当前页面直到指定页面
    RoutePredicate? predicate, // 路由移除的条件
  }) {
    if (replace) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    } else if (removeUntil) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => page),
          predicate ?? (route) => false);
    } else {
      Navigator.push(
        context,
        pageRouteBuilder ?? MaterialPageRoute(builder: (context) => page),
      );
    }
  }

  static void pushAnim(
    BuildContext context, // 当前上下文
    Widget page, // 目标页面
    {
    bool replace = false, // 是否替换当前页面
    bool removeUntil = false, // 是否移除当前页面直到指定页面
    RoutePredicate? predicate, // 路由移除的条件
  }) {
    push(context, page,
        pageRouteBuilder: defaultPageRouteBuilder(page),
        replace: replace,
        removeUntil: removeUntil,
        predicate: predicate);
  }

  /// 打开一个页面并等待其返回结果
  static Future<T?> openForResult<T>(
      BuildContext context,
      Widget page, {
        PageRouteBuilder? pageRouteBuilder, // 自定义构建器
        bool replace = false, // 是否替换当前页面
        bool removeUntil = false, // 是否移除当前页面直到指定页面
        RoutePredicate? predicate, // 路由移除的条件
      }) async {
    if (replace) {
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => page),
      ).then((value) => value as T?);
    } else if (removeUntil) {
      return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => page),
          predicate ?? (route) => false)
          .then((value) => value as T?);
    } else {
      return Navigator.push(
        context,
        pageRouteBuilder ?? defaultPageRouteBuilder(page),
      ).then((value) => value as T?);
    }
  }
  /// 打开URL
  static Future<void> launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      await launchUrl(uri);
    } catch (e) {
      Log.e('RouteUtils', 'Error launching URL: $e');
    }
  }

  /// 默认的PageRouteBuilder
  static PageRouteBuilder defaultPageRouteBuilder(Widget page) => PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
              position: animation.drive(
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                      .chain(CurveTween(curve: Curves.easeInOut))),
              child: child));
}
