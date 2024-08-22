import 'package:count_tools/data/model/item_data.dart';
import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:count_tools/page/subproject_info_page/subproject_info_page_vm.dart';
import 'package:count_tools/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildAddItemDialog(
  BuildContext context,
  BuildContext dialogContext,
  SubProjectData parentData,
  String projectId,
) {
  TextEditingController dateCon = TextEditingController();
  TextEditingController priceCon = TextEditingController();
  TextEditingController countCon = TextEditingController();
  TextEditingController eventCon = TextEditingController();
  TextEditingController typeCon = TextEditingController();
  return AlertDialog(
    title: const Text("新增项目"),
    content: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(
          controller: dateCon,
          decoration: const InputDecoration(labelText: "请输入日期（必填）")),
      TextField(
          controller: eventCon,
          decoration: const InputDecoration(labelText: "请输入活动名（可选）")),
      TextField(
          controller: priceCon,
          decoration: const InputDecoration(labelText: "请输入单张价格（可选）")),
      TextField(
          controller: countCon,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "请输入张数（必填）")),
      TextField(
          controller: typeCon,
          decoration: const InputDecoration(labelText: "请输入类型（有无签、宿题等）（可选）")),
    ]),
    actions: [
      TextButton(
          child: const Text("取消"),
          onPressed: () => Navigator.of(dialogContext).pop()),
      TextButton(
        child: const Text("确定"),
        onPressed: () {
          if (dateCon.text.isEmpty || countCon.text.isEmpty) {
            _showErrorDialog(dialogContext, "日期和张数是必填项。");
            return;
          }
          int num;
          try {
            num = int.parse(countCon.text);
          } catch (e) {
            _showErrorDialog(dialogContext, "张数必须是数字。");
            return;
          }

          Provider.of<SubProjectInfoViewModel>(dialogContext, listen: false).addItems(
              List.generate(
                  num,
                  (index) => ItemData(
                      id: generateUniqueId(),
                      price: priceCon.text,
                      eventName: eventCon.text,
                      date: dateCon.text,
                      itemName: parentData.name,
                      type: typeCon.text,
                      parentId: parentData.id,
                      projectId: projectId,
                      ext: "")));
          Provider.of<SubProjectInfoViewModel>(context, listen: false).updateSubProject(parentData);
          Navigator.of(dialogContext).pop();
        },
      ),
    ],
  );
}

// 错误提示对话框
void _showErrorDialog(BuildContext context, String message) => showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(title: const Text("错误"), content: Text(message), actions: [
          TextButton(
            child: const Text("确定"),
            onPressed: () => Navigator.of(context).pop(),
          )
        ]));