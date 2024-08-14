import 'package:count_tools/data/model/project_data.dart';
import 'package:count_tools/page/home_page/home_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildEditProjectDialog(
  BuildContext context,
  BuildContext dialogContext,
  ProjectData data,
) {
  TextEditingController titleCon = TextEditingController();
  TextEditingController subtitleCon = TextEditingController();
  return AlertDialog(
    title: const Text("编辑项目"),
    content: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(
          controller: titleCon,
          decoration: InputDecoration(hintText: data.title)),
      TextField(
          controller: subtitleCon,
          decoration: InputDecoration(hintText: data.subTitle))
    ]),
    actions: [
      TextButton(
          child: const Text("取消"),
          onPressed: () => Navigator.of(dialogContext).pop()),
      TextButton(
          child: const Text("确定"),
          onPressed: () {
            Provider.of<HomePageViewModel>(context, listen: false).editProject(
              data.copyWith(title: titleCon.text, subTitle: subtitleCon.text),
            );
            Navigator.of(dialogContext).pop();
          })
    ],
  );
}
