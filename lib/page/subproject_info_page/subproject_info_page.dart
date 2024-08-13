import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:count_tools/page/subproject_info_page/subproject_info_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubProjectInfoPage extends StatefulWidget {
  final SubProjectData parentData;
  final String projectId;

  const SubProjectInfoPage(
      {required this.parentData, Key? key, required this.projectId})
      : super(key: key);

  @override
  State<SubProjectInfoPage> createState() => _SubProjectInfoPageState();
}

class _SubProjectInfoPageState extends State<SubProjectInfoPage> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) =>
          SubProjectInfoViewModel()..loadItems(widget.parentData.parentId),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.parentData.name)),
        body: Center(child: _buildPersonInfoContent()),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => Provider.of<SubProjectInfoViewModel>(context,
                    listen: false)
                .addItemDialog(context, widget.parentData, widget.projectId),
          ),
        ),
      ));

  Widget _buildPersonInfoContent() => Column(children: [
        _buildPersonInfoTitle(),
        Expanded(child: _buildPersonInfoList())
      ]);

  Widget _buildPersonInfoTitle() => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        alignment: Alignment.center,
        child: Consumer<SubProjectInfoViewModel>(
          builder: (context, model, child) => Text(
            "当前项目总计：${model.items.length}",
            style: const TextStyle(fontSize: 20),
          ),
        ),
      );

  Widget _buildPersonInfoList() => Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
      );
}
