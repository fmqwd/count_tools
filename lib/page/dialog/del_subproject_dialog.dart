import 'package:count_tools/page/project_info_page/project_info_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildDelProjectDialog(
  BuildContext context,
  BuildContext dialogContext,
  String subProjectId,
) =>
    AlertDialog(
      title: const Text("删除项目"),
      content: const Text("删除后所有关联项目都会被删除，确定要删除吗？"),
      actions: [
        TextButton(
            child: const Text("取消"),
            onPressed: () => Navigator.of(dialogContext).pop()),
        TextButton(
          child: const Text("确定"),
          onPressed: () {
            Provider.of<ProjectInfoViewModel>(context, listen: false)
                .deleteSubProject(subProjectId);
            Navigator.of(dialogContext).pop();
          },
        ),
      ],
    );
