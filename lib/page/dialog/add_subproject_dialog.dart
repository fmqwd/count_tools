import 'package:count_tools/data/model/project_data.dart';
import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:count_tools/page/project_info_page/project_info_page_vm.dart';
import 'package:count_tools/utils/data_utils.dart';
import 'package:count_tools/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'color_picker_dialog.dart';

class AddSubProjectDialog extends StatefulWidget {
  final BuildContext extContext;
  final ProjectData parentData;

  const AddSubProjectDialog({
    Key? key,
    required this.extContext,
    required this.parentData,
  }) : super(key: key);

  @override
  AddSubProjectDialogState createState() => AddSubProjectDialogState();
}

class AddSubProjectDialogState extends State<AddSubProjectDialog> {
  Color selectedColor = Colors.blue;
  Color selectedTextColor = Colors.black;
  late TextEditingController nameCon;

  @override
  void initState() {
    super.initState();
    nameCon = TextEditingController();
  }

  @override
  void dispose() {
    nameCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            trailing: CircleAvatar(backgroundColor: selectedColor),
            onTap: () => showColorPicker(context, selectedColor,
                    (color) => setState(() => selectedColor = color)),
          ),
          ListTile(
            title: const Text('选择文本颜色'),
            trailing: CircleAvatar(backgroundColor: selectedTextColor),
            onTap: () => showColorPicker(context, selectedTextColor,
                    (color) => setState(() => selectedTextColor = color)),
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
                ext: "",
              ),
              widget.parentData,
            );
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
