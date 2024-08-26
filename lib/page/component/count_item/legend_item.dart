import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final CountItemData data;

  const LegendItem(this.data, {super.key});

  @override
  Widget build(BuildContext context) =>
      Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 16, height: 16, color: data.color),
        const SizedBox(width: 8),
        Text('${data.name} (${data.percent.toStringAsFixed(2)}%)'),
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