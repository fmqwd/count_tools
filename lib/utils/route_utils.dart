import 'package:flutter/material.dart';

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
    // 创建自定义的过渡效果
    var pageRouteBuilder = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {

        // 定义过渡的起始和结束位置
        const begin = Offset(1.0, 0.0); // 从右侧进入
        const end = Offset.zero; // 结束于当前位置
        const curve = Curves.easeInOut; // 过渡曲线

        // 使用 Tween 定义动画效果
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );

    push(context, page,
        pageRouteBuilder: pageRouteBuilder,
        replace: replace,
        removeUntil: removeUntil,
        predicate: predicate);
  }
}
