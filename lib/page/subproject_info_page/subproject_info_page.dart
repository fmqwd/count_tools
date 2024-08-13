import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:count_tools/page/component/single_item_widget.dart';
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
          SubProjectInfoViewModel()..loadItems(widget.parentData.id),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.parentData.name)),
        body: Center(child: _buildPersonInfoContent(widget.parentData.count)),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => Provider.of<SubProjectInfoViewModel>(context,
                    listen: false)
                .addItemDialog(context, widget.parentData, widget.projectId),
          ),
        ),
      ));

  Widget _buildPersonInfoContent(String count) => Column(children: [
        _buildPersonInfoTitle(count),
        Expanded(child: _buildPersonInfoList())
      ]);

  Widget _buildPersonInfoTitle(String count) => Container(
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
        child: Consumer<SubProjectInfoViewModel>(
          builder: (context, model, child) {
            if (model.items.isEmpty) {
              return const Center(child: Text('没有项目，点击+添加'));
            }
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: ListView.builder(
                itemCount: model.dates.length,
                itemBuilder: (context, index) => SingleItemWidget(
                  date: model.dates[index],
                  data: model.items.where((e) => e.date == model.dates[index]).toList(),
                ),
              ),
            );
          },
        ),
      );
}