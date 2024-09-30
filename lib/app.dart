import 'package:count_tools/page/home_page/home_page.dart';
import 'package:count_tools/utils/setting_utils.dart';
import 'package:count_tools/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'data/request/group_request.dart';


class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  MaterialColor _themeColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    setScreenOrientation(false);
    _initApp();
    _loadThemeColor();
  }

  Future<void> _loadThemeColor() async {
    MaterialColor color = await SettingUtils.getThemeColor();
    setState(() => _themeColor = color);
  }


  Future<void> _initApp() async {
    _initShared();
    _initData();
  }

  Future<void> _initData() async {
    GroupRest().fetchGroups();
  }

  Future<void> _initShared() async {
    if (!await SettingUtils.isNotFirstEnter()) {
      await SettingUtils.setIsNotFirstEnter();
      SettingUtils.setProjectInfoRowNum(5);
      SettingUtils.setProjectInfoSort('降序');
      SettingUtils.setShowMode('数量-百分比');
      SettingUtils.setIsShowTotalPrice(true);
    }
  }


  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'count_tools',
      theme: ThemeData(primarySwatch: _themeColor),
      home: const HomePage(title: '首页'));
}
