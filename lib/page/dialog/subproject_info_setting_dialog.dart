import 'package:count_tools/utils/safe_utils.dart';
import 'package:count_tools/utils/setting_utils.dart';
import 'package:flutter/material.dart';

void showSubProjectInfoSettingDialog(
    BuildContext context, void Function() callback) async {
  final settings = await _loadSettings();
  if (context.mounted) {
    showDialog(
        context: context,
        builder: (dialogContext) =>
            SettingDialog(initialSettings: settings, callback: callback));
  }
}

Future<Map<String, bool>> _loadSettings() async => {
      "isQuickAdd": await SettingUtils.getIsQuickAdd(),
      "isShowTotalPrice": await SettingUtils.getIsShowTotalPrice()
    };

class SettingDialog extends StatefulWidget {
  final void Function() callback;
  final Map<String, bool> initialSettings;

  const SettingDialog({
    Key? key,
    required this.initialSettings,
    required this.callback,
  }) : super(key: key);

  @override
  SettingDialogState createState() => SettingDialogState();
}

class SettingDialogState extends State<SettingDialog> {
  Map<String, bool> settings = {};

  @override
  void initState() {
    super.initState();
    settings = widget.initialSettings;
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
          title: const Text('信息设置'),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSwitch('是否开启快速添加？', 'isQuickAdd', false),
                _buildSwitch('是否显示金额', 'isShowTotalPrice', true),
              ]),
          actions: [
            TextButton(
                child: const Text('取消'), onPressed: () => Navigator.of(context).pop()),
            TextButton(
                child: const Text('确定'), onPressed: () => _saveSettings())
          ]);

  Widget _buildSwitch(String label, String key, bool defaultValue) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(label),
            Switch(
                value: settings[key] ?? defaultValue,
                onChanged: (newValue) => setState(() => settings[key] = newValue))
          ]);

  void _saveSettings() {
    SettingUtils.setIsQuickAdd(safeBool(settings['isQuickAdd']));
    SettingUtils.setIsShowTotalPrice(safeBool(settings['isShowTotalPrice']));
    widget.callback();
    Navigator.of(context).pop();
  }
}
