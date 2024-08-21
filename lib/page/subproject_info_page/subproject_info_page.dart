import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:count_tools/page/component/single_item_widget.dart';
import 'package:count_tools/page/custom_widget/remove_padding_widget.dart';
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
  late SubProjectInfoViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = SubProjectInfoViewModel()..loadItems(widget.parentData.id);
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
      value: _vm,
      child: Scaffold(
          appBar: AppBar(title: Text(widget.parentData.name), actions: [
            IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => _vm.showSettingDialog(context)),
          ]),
          body: Center(child: _buildPersonInfoContent(widget.parentData.count)),
          floatingActionButton:
              Builder(builder: (context) => _buildFloatButton())));

  Widget _buildPersonInfoContent(String count) => Column(children: [
        _buildPersonInfoTitle(),
        if (_vm.isShowPrice) _buildPersonInfoItem(),
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

  Widget _buildPersonInfoItem() => Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Consumer<SubProjectInfoViewModel>(
        builder: (context, model, child) {
          if (model.isShowPrice) {
            return Text('总计花费：${model.cost}');
          } else {
            return const SizedBox();
          }
        },
      ));

  Widget _buildPersonInfoList() => Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Consumer<SubProjectInfoViewModel>(
          builder: (context, model, child) {
            if (model.isQuickAdd) {
              return _buildQuickAddInfo();
            }
            if (model.items.isEmpty) {
              return const Center(child: Text('没有项目，点击+添加'));
            }
            return NonePaddingWidget(
              context: context,
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

  Widget _buildQuickAddInfo() => Container(
    alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: const Text("当前为快速添加模式，点击+将直接添加一个价格为0，日期为今天的项目，点击-将减少最后添加的项目（最少为0））"));

  Widget _buildFloatButton() =>
      Consumer<SubProjectInfoViewModel>(builder: (context, model, child) {
        if (model.isQuickAdd) {
          return Row(mainAxisSize: MainAxisSize.min, children: [
            FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => model.addItemClick(
                    context, widget.parentData, widget.projectId)),
            const SizedBox(width: 10),
            FloatingActionButton(
                child: const Icon(Icons.remove),
                onPressed: () => model.deleteItemClick(context,widget.parentData.id))
          ]);
        } else {
          return FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => model.addItemDialog(
                  context, widget.parentData, widget.projectId));
        }
      });
}
