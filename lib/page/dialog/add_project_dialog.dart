import 'package:count_tools/data/model/project_data.dart';
import 'package:count_tools/page/home_page/home_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildAddProjectDialog(
  BuildContext context,
  BuildContext dialogContext,
) {
  TextEditingController titleCon = TextEditingController();
  TextEditingController subtitleCon = TextEditingController();;

  return AlertDialog(
    title: const Text("新增项目"),
    content: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(
          controller: titleCon,
          decoration: const InputDecoration(labelText: "请输入标题（必填）")),
      TextField(
          controller: subtitleCon,
          decoration: const InputDecoration(labelText: "请输入描述（可选）")),
    ]),
    actions: [
      TextButton(
          child: const Text("取消"),
          onPressed: () => Navigator.of(dialogContext).pop()),
      TextButton(
        child: const Text("确定"),
        onPressed: () {
          Provider.of<HomePageViewModel>(context, listen: false).addProject(
              ProjectData(
                  id: "",
                  title: titleCon.text,
                  subTitle: subtitleCon.text,
                  count: "0",
                  ext: ""));
          Navigator.of(dialogContext).pop();
        },
      ),
    ],
  );
}
