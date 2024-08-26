import 'package:count_tools/page/component/count_item/color_count_pie_chart.dart';
import 'package:count_tools/page/component/count_item/name_num_count_pie_chart.dart';
import 'package:count_tools/page/count_page/count_page_vm.dart';
import 'package:count_tools/value/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountPage extends StatefulWidget {
  final String id;

  const CountPage({Key? key, required this.id}) : super(key: key);

  @override
  State<CountPage> createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {
  late CountPageViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = CountPageViewModel(widget.id)..loadDatas();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
      value: _vm,
      child: Scaffold(
          appBar: AppBar(title: const Text("统计"), actions: [
            IconButton(onPressed: () => {}, icon: const Icon(Icons.settings))
          ]),
          body: Center(
            child: ListView(children: [
              _buildColorCountTitle(),
              _buildColorCount(),
              const SizedBox(height: 32),
              _buildNameNumCountTitle(),
              _buildNameNumCount(),
              const SizedBox(height: 64),
            ]),
          )));

  Widget _buildColorCountTitle() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: const Text("当前项目颜色分布：", style: AppTextStyle.heading2));

  Widget _buildColorCount() =>
      Consumer<CountPageViewModel>(builder: (_, vm, __) {
        if (vm.colorData.isEmpty) {
          return const Text("暂无数据，请先添加");
        }
        return ColorPieChartWidget(vm.colorData, height: 400);
      });

  Widget _buildNameNumCountTitle() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: const Text("当前项目名称-数量分布：", style: AppTextStyle.heading2));

  Widget _buildNameNumCount() =>
      Consumer<CountPageViewModel>(builder: (_, vm, __) {
        if (vm.countNum < 1) {
          return const Center(child: Text("暂无详细数据，请先添加"));
        }
        return NameNumPieChartWidget(vm.subProjects, vm.countNum, height: 400);
      });
}
