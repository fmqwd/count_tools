import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:count_tools/page/project_info_page/project_info_page_vm.dart';
import 'package:count_tools/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'color_picker_dialog.dart';

class LongClickSubProjectDialog extends StatefulWidget {
  final BuildContext extContext;
  final SubProjectData data;

  const LongClickSubProjectDialog(
      {Key? key, required this.extContext, required this.data})
      : super(key: key);

  @override
  LongClickSubProjectDialogState createState() =>
      LongClickSubProjectDialogState();
}

class LongClickSubProjectDialogState extends State<LongClickSubProjectDialog> {
  Color selectedColor = Colors.blue;
  Color selectedTextColor = Colors.white;

  @override
  void initState() {
    super.initState();
    selectedColor = parseColor(widget.data.color);
    selectedTextColor = parseColor(widget.data.textColor);
  }

  @override
  Widget build(BuildContext context) {
    final nameCon = TextEditingController();
    nameCon.text = widget.data.name;

    return AlertDialog(
        title: const Text('修改信息'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
              controller: nameCon,
              decoration: const InputDecoration(labelText: "请输入姓名")),
          ListTile(
              title: const Text('选择颜色'),
              trailing: CircleAvatar(backgroundColor: selectedColor),
              onTap: () => showColorPicker(context, selectedColor,
                  (color) => setState(() => selectedColor = color))),
          ListTile(
              title: const Text('选择字体颜色'),
              trailing: CircleAvatar(backgroundColor: selectedTextColor),
              onTap: () => showColorPicker(context, selectedTextColor,
                  (color) => setState(() => selectedTextColor = color)))
        ]),
        actions: [
          TextButton(
              child: const Text("删除"),
              onPressed: () => {
                Provider.of<ProjectInfoViewModel>(widget.extContext, listen: false).deleteSubProject(widget.data.id),
                Navigator.of(context).pop()}),
          TextButton(
              child: const Text("取消"),
              onPressed: () => Navigator.of(context).pop()),
          TextButton(
              child: const Text("确定"),
              onPressed: () => {
                Provider.of<ProjectInfoViewModel>(widget.extContext, listen: false).editSubProject(widget.data.copyWith(name: nameCon.text, color: intColorToHex(selectedColor), textColor: intColorToHex(selectedTextColor))),
                Navigator.of(context).pop()}
              ),
        ]);
  }
}
