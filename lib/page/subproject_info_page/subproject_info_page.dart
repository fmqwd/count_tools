import 'package:count_tools/data/model/item_data.dart';
import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:count_tools/page/component/single_item_widget.dart';
import 'package:count_tools/page/custom_widget/remove_padding_widget.dart';
import 'package:count_tools/page/subproject_info_page/subproject_info_page_vm.dart';
import 'package:count_tools/utils/data_utils.dart';
import 'package:count_tools/utils/safe_utils.dart';
import 'package:count_tools/value/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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

  TextEditingController dateCon = TextEditingController();
  TextEditingController priceCon = TextEditingController();
  TextEditingController countCon = TextEditingController();
  TextEditingController eventCon = TextEditingController();
  TextEditingController typeCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateCon.text = getCurrentDate();
    priceCon.text = '0';
    countCon.text = '1';
    eventCon.text = '';
    typeCon.text = '';
    _vm = SubProjectInfoViewModel()..loadItems(widget.parentData.id);
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
      value: _vm,
      child: Scaffold(
          appBar: AppBar(title: Text(widget.parentData.name), actions: [
            IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => _vm.showSettingDialog(context))
          ]),
          body: Center(child: _buildSubProjectContent())));

  Widget _buildSubProjectContent() => Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: ListView(children: [
        const SizedBox(height: 16),
        Center(child: _buildSum()),
        const SizedBox(height: 8),
        Center(child: _buildCost()),
        const SizedBox(height: 32),
        _buildItem(),
        _buildButtons(),
        const SizedBox(height: 32),
        _buildAddInfoList()
      ]));

  Widget _buildSum() => Consumer<SubProjectInfoViewModel>(
      builder: (__, vm, _) =>
          Text('当前项目总计：${vm.items.length}', style: AppTextStyle.heading3));

  Widget _buildCost() => Consumer<SubProjectInfoViewModel>(
      builder: (__, vm, _) =>
          vm.isShowPrice ? Text('总计花费：${vm.cost}') : const SizedBox());

  Widget _buildItem() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
            controller: dateCon,
            decoration: InputDecoration(
                labelText: "请输入日期（必填，点击图标可展开日历）",
                suffixIcon: GestureDetector(
                    onTap: () => DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2000, 1, 1),
                        maxTime: DateTime(2100, 12, 31),
                        onConfirm: (date) => dateCon.text = formatDate(date),
                        currentTime: DateTime.now(),
                        locale: LocaleType.zh),
                    child: const Icon(Icons.calendar_month)))),
        TextField(
            controller: eventCon,
            decoration: const InputDecoration(
                labelText: "请输入活动名（可选）", suffixIcon: Icon(Icons.event_note))),
        TextField(
            controller: priceCon,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                labelText: "请输入单张价格（可选）", suffixIcon: Icon(Icons.money))),
        TextField(
            controller: countCon,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                labelText: "请输入张数（必填）", suffixIcon: Icon(Icons.numbers))),
        TextField(
            controller: typeCon,
            decoration: const InputDecoration(
                labelText: "请输入类型（有无签、宿题等）（可选）", suffixIcon: Icon(Icons.type_specimen_outlined))),
        const SizedBox(height: 30)
      ]));

  Widget _buildButtons() => Consumer<SubProjectInfoViewModel>(
      builder: (context, vm, _) =>
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _buildButton(() => _onAddClickListener(vm, context), true),
            _buildButton(() => vm.deleteItemClick(context, widget.parentData), false)
          ]));

  void _onAddClickListener(vm, context) async {
    vm.addItemClick(
        widget.parentData,
        safeInt(countCon.text, defaultValue: 1),
        ItemData(
            date: dateCon.text,
            price: priceCon.text,
            type: typeCon.text,
            id: '',
            eventName: eventCon.text,
            itemName: widget.parentData.name,
            parentId: widget.parentData.id,
            projectId: widget.projectId,
            ext: ''),
        context);
  }

  Widget _buildButton(GestureTapCallback? onTap, bool left) => GestureDetector(
      onTap: onTap,
      child: Container(
          width: 50,
          height: 40,
          alignment: Alignment.center,
          color: left ? Colors.blue : Colors.cyan,
          child: left ? const Icon(Icons.add) : const Icon(Icons.remove)));

  Widget _buildAddInfoList() => Consumer<SubProjectInfoViewModel>(
      builder: (context, vm, child) => NonePaddingWidget(
          context: context,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vm.dates.length,
              itemBuilder: (context, index) => SingleItemWidget(
                  date: vm.dates[index],
                  data: vm.items.where((e) => e.date == vm.dates[index]).toList()))));
}
