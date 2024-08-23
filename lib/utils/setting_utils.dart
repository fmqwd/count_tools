//首页设置工具，包括从shared preferences中获取设置，保存设置，更新设置
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

  static Future<void> setThemeColor(String color) async =>
      await SharedUtils.setString("themeColor", color);

  static Future<Widget> getThemeColorWidget() async =>
      _getThemeColorWidget(await getThemeColor());

  static Widget _getThemeColorWidget(MaterialColor color) => Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
      );

  //设置全局theme颜色
  static Future<void> setThemeColorWidget(MaterialColor color) async =>
      await SharedUtils.setString("themeColor", color.value.toString());

  //获取projectInfo页面显示行数
  static Future<int> getProjectInfoRowNum() async =>
      await SharedUtils.getInt("projectInfoRowNum");

  //设置projectInfo页面显示行数
  static Future<void> setProjectInfoRowNum(int rowNum) async {
    await SharedUtils.setInt("projectInfoRowNum", rowNum);
  }

  //设置projectInfo页面排序依据
  static Future<void> setProjectInfoSort(String sort) async {
    await SharedUtils.setString("projectInfoSort", sort);
  }

  //获取projectInfo页面排序依据
  static Future<String> getProjectInfoSort() async =>
      await SharedUtils.getString("projectInfoSort");

  //设置projectInfo页面排序方式
  static Future<void> setProjectInfoSortDirection(String sortDirection) async =>
      await SharedUtils.setString("projectInfoSortDirection", sortDirection);

  //判断是否首次进入app
  static Future<bool> isNotFirstEnter() async =>
      await SharedUtils.getBool("isNotFirstEnter");

  //设置首次进入app
  static Future<void> setIsNotFirstEnter() async =>
      await SharedUtils.setBool("isNotFirstEnter", true);

  //获取显示模式
  static Future<String> getShowMode() async =>
      await SharedUtils.getString("showMode");

  //设置显示模式
  static Future<void> setShowMode(String showMode) async =>
      await SharedUtils.setString("showMode", showMode);

  //设置是否显示总价
  static Future<void> setIsShowTotalPrice(bool isShowTotalPrice) async =>
      await SharedUtils.setBool("isShowTotalPrice", isShowTotalPrice);

  //获取是否显示总价
  static Future<bool> getIsShowTotalPrice() async =>
      await SharedUtils.getBool("isShowTotalPrice");

  //设置是否主动接受更新
  static Future<void> setIsAutoUpdate(bool isAutoUpdate) async =>
      await SharedUtils.setBool("isAutoUpdate", isAutoUpdate);

  //获取是否主动接受更新
  static Future<bool> getIsAutoUpdate() async =>
      await SharedUtils.getBool("isAutoUpdate");

}

Widget getThemeColorWidget() => FutureBuilder<Widget>(
      future: SettingUtils.getThemeColorWidget(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Container();
        } else if (snapshot.hasData) {
          return snapshot.data!;
        } else {
          return Container();
        }
      },
    );
