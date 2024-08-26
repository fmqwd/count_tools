import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final CountItemData data;
  final bool isShowCount;

  const LegendItem(this.data, {super.key, this.isShowCount = false});

  @override
  Widget build(BuildContext context) =>
      Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: data.color,
              borderRadius: BorderRadius.circular(4)),
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 4),
        Row(children: [
          Text(data.name),
          if (isShowCount) Text('：${data.count}-'),
          Text('(${data.percent.toStringAsFixed(2)}%)'),
        ]),
        const SizedBox(width: 16)
      ]);
}

class CountItemData {
  final Color color;
  final String name;
  final double percent;
  final int count;

  CountItemData(this.color, this.name, this.percent, this.count);
}
