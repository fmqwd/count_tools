import 'package:charts_flutter/flutter.dart' as ch;
import 'package:count_tools/utils/safe_utils.dart';
import 'package:count_tools/utils/ui_utils.dart';
import 'package:flutter/material.dart';

import 'legend_item.dart';

class ColorPieChartWidget extends StatelessWidget {
  final Map<Color, int> data;
  final double? height;

  const ColorPieChartWidget(this.data, {Key? key, this.height})
      : super(key: key);

  List<ch.Series<CountItemData, String>> _create() => [
        ch.Series(
          id: 'Sales',
          measureFn: (s, _) => safeInt(s.count),
          domainFn: (s, _) => s.color.toString(),
          colorFn: (s, _) => ch.ColorUtil.fromDartColor(s.color),
          data: (data.entries.toList()
                ..sort((b, a) => (HSLColor.fromColor(a.key).hue)
                    .compareTo(HSLColor.fromColor(b.key).hue)))
              .map((e) => CountItemData(
                    e.key,
                    e.value.toString(),
                    (e.value / data.values.reduce((a, b) => a + b)) * 100,
                    e.value,
                  ))
              .toList(),
          labelAccessorFn: (s, _) => '${s.percent.toStringAsFixed(2)}%',
          insideLabelStyleAccessorFn: (s, _) => ch.TextStyleSpec(
              color: ch.ColorUtil.fromDartColor(getTextColor(s.color))),
        )
      ];

  @override
  Widget build(BuildContext context) =>
      Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
            height: height,
            child: ch.PieChart<String>(_create(),
                animate: true,
                defaultRenderer: ch.ArcRendererConfig(arcRendererDecorators: [
                  ch.ArcLabelDecorator(
                      labelPosition: ch.ArcLabelPosition.inside)
                ]))),
        const SizedBox(height: 16),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Wrap(
                alignment: WrapAlignment.center,
                children: (_create()
                    .first
                    .data..sort((b, a) => a.count.compareTo(b.count)))
                    .map((data) => LegendItem(data))
                    .toList()))
      ]);
}
