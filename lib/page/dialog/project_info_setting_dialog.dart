import 'package:count_tools/utils/setting_utils.dart';
import 'package:flutter/material.dart';

void showProjectInfoSettingDialog(BuildContext context, void Function() callback) async {
  final settings = await _loadSettings();
  if (context.mounted) {
    showDialog(
        context: context,
        builder: (dialogContext) =>
            SettingDialog(initialSettings: settings, callback: callback));
  }
}

Future<Map<String, dynamic>> _loadSettings() async => {
      'row': await SettingUtils.getProjectInfoRowNum(),
      'order': await SettingUtils.getProjectInfoSort(),
      'showType': await SettingUtils.getShowMode()
    };

class SettingDialog extends StatefulWidget {
  final void Function() callback;
  final Map<String, dynamic> initialSettings;

  const SettingDialog({
    Key? key,
    required this.initialSettings,
    required this.callback,
  }) : super(key: key);

  @override
  SettingDialogState createState() => SettingDialogState();
}

class SettingDialogState extends State<SettingDialog> {
  final List<int> rowOptions = [2, 3, 4, 5, 6, 7];
  final List<String> orderOptions = ['升序', '降序'];
  final List<String> displayOptions = ['数量-百分比', '排名-百分比', '排名-数量', '仅排名', '仅百分比', '仅数量'];

  Map<String, dynamic> settings = {};

  @override
  void initState() {
    super.initState();
    settings = widget.initialSettings;
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
          title: const Text('项目信息设置'),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdown('行数', 'row', rowOptions),
                _buildDropdown('排序方式', 'order', orderOptions),
                _buildDropdown('显示格式', 'showType', displayOptions)
              ]),
          actions: [
            TextButton(child: const Text('取消'), onPressed: () => Navigator.of(context).pop()),
            TextButton(child: const Text('确定'), onPressed: () => _saveSettings())
          ]);

  Widget _buildDropdown(String label, String key, List<dynamic> options) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label),
        DropdownButtonFormField<dynamic>(
            value: settings[key],
            hint: Text(settings[key].toString()),
            onChanged: (newValue) => setState(() => settings[key] = newValue),
            items: options.map((value) => DropdownMenuItem(value: value, child: Text(value.toString()))).toList())
      ]);

  void _saveSettings() {
    SettingUtils.setProjectInfoRowNum(settings['row']);
    SettingUtils.setProjectInfoSort(settings['order']);
    SettingUtils.setShowMode(settings['showType']);
    widget.callback();
    Navigator.of(context).pop();
  }
}
