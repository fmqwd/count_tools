import 'package:count_tools/data/model/activity_data.dart';
import 'package:count_tools/page/component/list_item/single_activity_item.dart';
import 'package:count_tools/page/custom_widget/remove_padding_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'activity_list_page_vm.dart';

class ActivityListPage extends StatefulWidget {
  const ActivityListPage({super.key});

  @override
  State<ActivityListPage> createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  late ActivityListPageViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = ActivityListPageViewModel()..loadData();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
      value: _vm,
      child: Scaffold(
        appBar: AppBar(title: const Text('活动列表')),
        body: Center(child: _buildPageBody()),
        floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
                child: const Icon(Icons.add), onPressed: () => {})),
      ));

  Widget _buildPageBody() => Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: ListView(
            children: [const SizedBox(height: 20), _buildActivityList()]),
      );

  Widget _buildActivityList() =>
      Consumer<ActivityListPageViewModel>(builder: (context, vm, _) {
        if (vm.activityData.isEmpty) {
          return const Center(child: Text('暂无活动'));
        }
        int count = vm.activityData.length;
        return SizedBox(
            height: count * 100,
            child: NonePaddingWidget(
                context: context,
                child: ListView.builder(
                    itemCount: count,
                    itemBuilder: (context, index) => SingleActivityItem(
                        data: vm.activityData[index], onClick: () => {}))));
      });
}
