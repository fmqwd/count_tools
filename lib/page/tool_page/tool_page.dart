import 'package:count_tools/page/tool_page/tool_page_vm.dart';
import 'package:count_tools/utils/route_utils.dart';
import 'package:count_tools/value/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'child_tool/text_display_board_input.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({Key? key}) : super(key: key);

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  late ToolsPageViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = ToolsPageViewModel();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
      value: _vm,
      child: Scaffold(
          appBar: AppBar(title: const Text('工具箱')),
          body: Center(child: _buildToolsBody())));

  Widget _buildToolsBody() => ListView(children: [_buildActivityTools()]);

  Widget _buildActivityTools() => ExpansionTile(
          leading: const Icon(Icons.event),
          title: const Text('活动工具'),
          initiallyExpanded: true,
          children: [
            Row(children: [
              const SizedBox(width: 10),
              _buildSingeTool('倒计时',(){}),
              const SizedBox(width: 4),
              _buildSingeTool('文字灯牌',
                  () => RouteUtils.pushAnim(context, const TextDisplayBoard())),
              const SizedBox(width: 10)
            ])
          ]);

  Widget _buildSingeTool(String name, void Function() onTap) => GestureDetector(
      child: Container(
          height: 80,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 8),
          width: (MediaQuery.of(context).size.width / 2) - 12,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(name, style: AppTextStyle.bodyBd)),
      onTap: () => onTap());
}
