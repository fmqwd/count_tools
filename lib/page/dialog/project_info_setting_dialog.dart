import 'package:count_tools/utils/setting_utils.dart';
import 'package:flutter/material.dart';

void showProjectInfoSettingDialog(BuildContext context) async {
  final int row = await SettingUtils.getProjectInfoRowNum();
  final String order = await SettingUtils.getProjectInfoSort();
  final String criteria = await SettingUtils.getProjectInfoSortType();
  final String showType = await SettingUtils.getShowMode();

  if (context.mounted) {
    showDialog(
        context: context,
        builder: (dialogContext) =>
            SettingDialog(row: row, order: order, criteria: criteria, showType: showType,));
  }
}

class SettingDialog extends StatefulWidget {
  final int row;
  final String order;
  final String criteria;
  final String showType;

  const SettingDialog({
    super.key,
    required this.row,
    required this.order,
    required this.criteria,
    required this.showType,
  });

  @override
  SettingDialogState createState() => SettingDialogState();
}

class SettingDialogState extends State<SettingDialog> {
  int? selectedRowCount;
  String? selectedOrder;
  String? selectedCriteria;
  String? selectedShowType;
  List<int> rowCountOptions = [4, 5, 6];
  List<String> orderOptions = ['升序', '降序'];
  List<String> criteriaOptions = ['数量', '金额'];
  List<String> showType = ['数量-百分比',"排名-百分比","排名-数量","仅排名","仅百分比","仅数量"];

  @override
  Widget build(BuildContext context) => AlertDialog(
          title: const Text('项目信息设置'),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("行数"),
                DropdownButton(
                    value: selectedRowCount,
                    hint: Text(widget.row.toString()),
                    onChanged: (int? newValue) => setState(() {selectedRowCount = newValue;SettingUtils.setProjectInfoRowNum(newValue!);}),
                    items: rowCountOptions.map((value) => DropdownMenuItem(value: value, child: Text(value.toString()))).toList()),
                const Text("排序方式"),
                DropdownButton(
                    hint: Text(widget.order),
                    value: selectedOrder,
                    onChanged: (String? newValue) => setState(() {selectedOrder = newValue;SettingUtils.setProjectInfoSort(newValue!);}),
                    items: orderOptions.map((String value) => DropdownMenuItem(value: value, child: Text(value))).toList()),
                const Text("排序条件"),
                DropdownButton(
                  hint: Text(widget.criteria),
                  value: selectedCriteria,
                  onChanged: (String? newValue) => setState(() {selectedCriteria = newValue;SettingUtils.setProjectInfoSortType(newValue!);}),
                  items: criteriaOptions.map((String value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                ),
                const Text("显示格式"),
                DropdownButton(
                  hint: Text(widget.showType),
                  value:selectedShowType,
                  onChanged: (String? newValue) => setState(() {selectedShowType = newValue;SettingUtils.setShowMode(newValue!);}),
                  items: showType.map((String value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                )
              ]),
          actions: [TextButton(child: const Text('取消'), onPressed: () => Navigator.of(context).pop())]);
}
