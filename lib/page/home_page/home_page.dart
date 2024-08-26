import 'package:count_tools/page/component/list_item/single_project_widget.dart';
import 'package:count_tools/page/custom_widget/remove_padding_widget.dart';
import 'package:count_tools/page/dialog/version_check_dialog.dart';
import 'package:count_tools/utils/setting_utils.dart';
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
    _checkUpdate();
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
                key: const Key('add_project_btn'),
                  child: const Icon(Icons.add),
                  onPressed: () => _vm.addProjectDialog(context)))));

  Widget _buildHomePageProjectList() =>
      Consumer<HomePageViewModel>(builder: (context, vm, __) {
        if (vm.projects.isEmpty) {
          return const Center(child: Text('没有项目，点击+添加'));
        }
        return NonePaddingWidget(
            context: context,
            child: RefreshIndicator(
                onRefresh: _vm.loadProjects,
                child: ListView.builder(
                    itemCount: vm.projects.length,
                    itemBuilder: (context, index) => SingleProjectWidget(
                        project: vm.projects[index],
                        onDelete: () => vm.delProjectDialog(context, vm.projects[index].id),
                        onClick: () => vm.pushProjectInfoPage(context, vm.projects[index]),
                        onEdit: () => vm.editProjectDialog(context, vm.projects[index])))));
      });

  Future<void> _checkUpdate() async {
    if (await SettingUtils.getIsAutoUpdate()) {
      if (context.mounted) {
        VersionUpdateChecker(context).checkForUpdatesInBackground();
      }
    }
  }
}
