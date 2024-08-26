import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:count_tools/utils/safe_utils.dart';
import 'package:count_tools/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as ch;

import 'legend_item.dart';

class NameNumPieChartSample extends StatelessWidget {
  final List<SubProjectData> data;
  final int count;
  final double? height;

  const NameNumPieChartSample(this.data, this.count, {Key? key, this.height})
      : super(key: key);

  List<ch.Series<CountItemData, String>> _create() => [
        ch.Series(
          id: 'PieChart',
          measureFn: (s, _) => safeInt(s.count),
          domainFn: (s, _) => s.color.toString(),
          colorFn: (s, _) => ch.ColorUtil.fromDartColor(s.color),
          data: (data
              .map((e) => CountItemData(
                    parseColor(e.color),
                    e.name,
                    (safeInt(e.count) / count) * 100,
                    safeInt(e.count),
                  ))
              .toList()),
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
                children: _create()
                    .first
                    .data
                    .map((data) => LegendItem(data))
                    .toList()))
      ]);
}
