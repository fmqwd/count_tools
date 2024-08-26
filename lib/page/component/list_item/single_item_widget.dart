import 'package:count_tools/data/model/item_data.dart';
import 'package:count_tools/value/style/text_style.dart';
import 'package:flutter/material.dart';

class SingleItemWidget extends StatelessWidget {
  final String date;
  final List<ItemData> data;

  const SingleItemWidget({Key? key, required this.date, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
          child: Column(children: [_buildTitle(), _buildCountList()]),
          onLongPress: () {}));

  Widget _buildTitle() => Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Text("$date (${data.length})", style: AppTextStyle.heading3));

  Widget _buildCountList() => ExpansionTile(
      title: const Text('点击展开/折叠数据'),
      children: data.map((item) => _buildCountItem(item)).toList());

  Widget _buildCountItem(ItemData item) {
    if (item.eventName.isEmpty && item.type.isEmpty && item.price.isEmpty) {
      return const SizedBox();
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Row(
        children: [
          Text(item.eventName, style: AppTextStyle.bodyText2),
          const SizedBox(width: 12),
          Text(item.type, style: AppTextStyle.bodyText2),
          const SizedBox(width: 12),
          Text(item.price, style: AppTextStyle.bodyText2),
        ],
      ),
    );
  }
}
