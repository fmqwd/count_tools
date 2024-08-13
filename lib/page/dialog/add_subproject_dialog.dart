import 'package:count_tools/data/model/project_data.dart';
import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:count_tools/page/home_page/home_page_vm.dart';
import 'package:count_tools/page/project_info_page/project_info_page_vm.dart';
import 'package:count_tools/utils/data_utils.dart';
import 'package:count_tools/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddSubProjectDialog extends StatefulWidget {
  final BuildContext extContext;
  final ProjectData parentData;

  const AddSubProjectDialog(
      {Key? key, required this.extContext, required this.parentData})
      : super(key: key);

  @override
  AddSubProjectDialogState createState() => AddSubProjectDialogState();
}

class AddSubProjectDialogState extends State<AddSubProjectDialog> {
  Color selectedColor = Colors.blue;
  Color selectedTextColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    final nameCon = TextEditingController();
    return AlertDialog(
      title: const Text("新增项目"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameCon,
            decoration: const InputDecoration(labelText: "请输入姓名"),
          ),
          ListTile(
            title: const Text('选择颜色'),
            trailing: CircleAvatar(
              backgroundColor: selectedColor,
            ),
            onTap: () {
              _showColorPicker(context, selectedColor, (color) {
                setState(() {
                  selectedColor = color;
                });
              });
            },
          ),
          ListTile(
            title: const Text('选择文本颜色'),
            trailing: CircleAvatar(
              backgroundColor: selectedTextColor,
            ),
            onTap: () {
              _showColorPicker(context, selectedTextColor, (color) {
                setState(() {
                  selectedTextColor = color;
                });
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("取消"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text("确定"),
          onPressed: () {
            Provider.of<ProjectInfoViewModel>(widget.extContext, listen: false)
                .addSubProject(
                    SubProjectData(
                        id: generateUniqueId(),
                        name: nameCon.text,
                        count: "0",
                        countPre: "0.0%",
                        color: intColorToHex(selectedColor),
                        textColor: intColorToHex(selectedTextColor),
                        parentId: widget.parentData.id,
                        ext: ""),
                    widget.parentData);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void _showColorPicker(BuildContext context, Color initialColor,
          ValueChanged<Color> onColorChanged) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('选择颜色'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: initialColor,
              onColorChanged: onColorChanged,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              child: const Text('确定'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
}
