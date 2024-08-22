import 'package:count_tools/page/dialog/about_dialog.dart';
import 'package:count_tools/page/dialog/choose_theme_dialog.dart';
import 'package:count_tools/page/dialog/user_info_dialog.dart';
import 'package:count_tools/page/dialog/version_check_dialog.dart';
import 'package:count_tools/utils/setting_utils.dart';
import 'package:count_tools/value/info.dart';
import 'package:count_tools/value/style/text_style.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final ValueNotifier<bool> _isAutoUpdate = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _loadInitialState();
  }

  Future<void> _loadInitialState() async {
    bool initialValue = await SettingUtils.getIsAutoUpdate();
    _isAutoUpdate.value = initialValue;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFF2F3F5),
        appBar: AppBar(title: const Text('设置')),
        body: Center(child: _buildContent(context)),
      );

  Widget _buildContent(BuildContext context) => Column(children: [
        const SizedBox(height: 12),
        _buildPersonInfo(),
        const SizedBox(height: 4),
        _buildThemeChoose(),
        const SizedBox(height: 30),
        _buildUpdate(),
        const SizedBox(height: 4),
        _buildUpdateSetting(),
        const SizedBox(height: 30),
        _buildAbout(),
      ]);

  //个人信息
  Widget _buildPersonInfo() => _buildSettingLine(
      Row(children: [
        const Text('个人信息', style: AppTextStyle.bodyBig),
        Expanded(child: Container()),
        const Icon(Icons.arrow_forward_ios_rounded, size: 16)
      ]),
      () => showUserInfoDialog(context));

  //主题选择
  Widget _buildThemeChoose() => _buildSettingLine(
      Row(children: [
        const Text('主题选择', style: AppTextStyle.bodyBig),
        Expanded(child: Container()),
        getThemeColorWidget(),
        const SizedBox(width: 8),
        const Icon(Icons.arrow_forward_ios_rounded, size: 16)
      ]),
      () => showThemePicker(context, (bool isChange) => setState(() => {})));

  //关于
  Widget _buildAbout() => _buildSettingLine(
      Row(children: [
        const Text('关于', style: AppTextStyle.bodyBig),
        Expanded(child: Container()),
        const Icon(Icons.arrow_forward_ios_rounded, size: 16)
      ]),
      () => showAppAboutDialog(context));

  //检查更新
  Widget _buildUpdate() => _buildSettingLine(
      Row(children: [
        const Text('检查更新', style: AppTextStyle.bodyBig),
        Expanded(child: Container()),
        Text("v${AppInfo.appVersion}", style: AppTextStyle.bodyBd),
        const SizedBox(width: 8),
        const Icon(Icons.arrow_forward_ios_rounded, size: 16)
      ]),
      () => VersionUpdateChecker(context).checkForUpdates());

  //更新设置
  Widget _buildUpdateSetting() => _buildSettingLine(
      Row(children: [
        const Text('更新推送开关', style: AppTextStyle.bodyBig),
        Expanded(child: Container()),
        _autoUpdateSwitch(),
        const SizedBox(width: 8),
        const Icon(Icons.arrow_forward_ios_rounded, size: 16)
      ]),
      null);

  Widget _buildSettingLine(Widget child, GestureTapCallback? onTap) =>
      GestureDetector(
          onTap: onTap,
          child: Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 9),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: child));

  Widget _autoUpdateSwitch() => ValueListenableBuilder<bool>(
      valueListenable: _isAutoUpdate,
      builder: (context, isAutoUpdate, child) => Switch(
          value: isAutoUpdate,
          onChanged: (value) async {
            await SettingUtils.setIsAutoUpdate(value);
            _isAutoUpdate.value = value;
          }));
}
