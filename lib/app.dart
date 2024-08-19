import 'package:count_tools/page/home_page/home_page.dart';
import 'package:count_tools/utils/setting_utils.dart';
import 'package:flutter/material.dart';

import 'data/database/data_base.dart';

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
    _initApp();
    _loadThemeColor();
    _initializeDatabase();
  }

  Future<void> _loadThemeColor() async {
    MaterialColor color = await SettingUtils.getThemeColor();
    setState(() => _themeColor = color);
  }

  Future<void> _initializeDatabase() async {
    DatabaseHelper();
  }

  Future<void> _initApp() async {
    if (!await SettingUtils.isNotFirstEnter()) {
      await SettingUtils.setIsNotFirstEnter();
      SettingUtils.setProjectInfoRowNum(5);
      SettingUtils.setProjectInfoSort('降序');
      SettingUtils.setShowMode('数量-百分比');
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'count_tools',
      theme: ThemeData(primarySwatch: _themeColor),
      home: const HomePage(title: '首页'));
}
