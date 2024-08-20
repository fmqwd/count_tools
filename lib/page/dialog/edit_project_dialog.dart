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
  titleCon.text = data.title;
  TextEditingController subtitleCon = TextEditingController();
  subtitleCon.text = data.subTitle;
  return AlertDialog(
    title: const Text("编辑项目"),
    content: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(controller: titleCon),
      TextField(controller: subtitleCon)
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
