import 'package:count_tools/page/component/single_project_widget.dart';
import 'package:count_tools/page/custom_widget/remove_padding_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page_vm.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = HomePageViewModel()..loadProjects();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
      value: _vm,
      child: Scaffold(
          appBar: AppBar(title: Text(widget.title), actions: [
            IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => _vm.pushSetPage(context))
          ]),
          body: Center(child: _buildHomePageProjectList()),
          floatingActionButton: Builder(
              builder: (context) => FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () => _vm.addProjectDialog(context)))));

  Widget _buildHomePageProjectList() =>
      Consumer<HomePageViewModel>(builder: (context, model, child) {
        if (model.projects.isEmpty) {
          return const Center(child: Text('没有项目，点击+添加'));
        }
        return NonePaddingWidget(
            context: context,
            child: ListView.builder(
                itemCount: model.projects.length,
                itemBuilder: (context, index) => SingleProjectWidget(
                    project: model.projects[index],
                    onDelete: () => model.delProjectDialog(
                        context, model.projects[index].id),
                    onClick: () => model.pushProjectInfoPage(
                        context, model.projects[index]),
                    onEdit: () => model.editProjectDialog(
                        context, model.projects[index]))));
      });
}
