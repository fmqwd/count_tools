import 'package:count_tools/page/component/list_item/single_group_item_widget.dart';
import 'package:count_tools/page/custom_widget/remove_padding_widget.dart';
import 'package:count_tools/page/tool_page/child_tool/info_tools/group_page/group_list_page_vm.dart';
import 'package:count_tools/utils/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_group_page.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key});

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  late GroupListPageViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = GroupListPageViewModel()..loadData();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
      value: _vm,
      child: Scaffold(
        appBar: AppBar(title: const Text('团体列表')),
        body: Center(child: _buildPageBody()),
        floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () =>
                    RouteUtils.openForResult(context, const AddGroupPage()))),
      ));

  Widget _buildPageBody() => Container(
        alignment: Alignment.center,
        width: double.infinity,
        child:
            ListView(children: [const SizedBox(height: 20), _buildGroupList()]),
      );

  Widget _buildGroupList() =>
      Consumer<GroupListPageViewModel>(builder: (context, vm, _) {
        if (vm.groupList.isEmpty) {
          return const Center(child: Text('暂无数据'));
        } else {
          int count = vm.groupList.length;
          return SizedBox(
              height: count * 100,
              child: NonePaddingWidget(
                context: context,
                child: ListView.builder(
                    itemCount: count,
                    itemBuilder: (context, index) =>
                        SingleGroupItem(data: vm.groupList[index])),
              ));
        }
      });
}
