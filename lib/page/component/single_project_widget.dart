import 'package:count_tools/data/model/project_data.dart';
import 'package:count_tools/value/style/text_style.dart';
import 'package:flutter/material.dart';

class SingleProjectWidget extends StatelessWidget {
  final ProjectData project;
  final VoidCallback onClick;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SingleProjectWidget({
    Key? key,
    required this.project,
    required this.onDelete,
    required this.onClick,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onClick,
        child: Container(
            width: double.infinity,
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Row(children: [
                  Text(project.title, style: AppTextStyle.heading3),
                  Expanded(child: Container()),
                  Text(project.count, style: AppTextStyle.bodyBd),
                ]),
                const SizedBox(height: 3),
                Text(project.subTitle),
                const SizedBox(height: 6),
                Expanded(child: Container()),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  GestureDetector(onTap: onDelete, child: const Icon(Icons.delete, size: 20)),
                  const SizedBox(width: 12),
                  GestureDetector(onTap: onEdit, child: const Icon(Icons.edit, size: 20))
                ])
              ],
            )),
      );
}
