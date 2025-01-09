import 'package:flutter/material.dart';

import 'annual_statistics_vm.dart';

class AnnualStatisticsPage extends StatefulWidget {
  const AnnualStatisticsPage({super.key});

  @override
  State<AnnualStatisticsPage> createState() => _AnnualStatisticsState();
}

class _AnnualStatisticsState extends State<AnnualStatisticsPage> {
  late final AnnualStatisticsViewModel _vm;
  final GlobalKey _listViewKey = GlobalKey(); // 用于捕获 ListView 的渲染内容

  @override
  void initState() {
    super.initState();
    _vm = AnnualStatisticsViewModel()
      ..addListener(_onViewModelChanged)
      ..loadData();
  }

  void _onViewModelChanged() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _vm.removeListener(_onViewModelChanged);
    super.dispose();
  }

  // 计算年度总数
  int _getTotalCountForYear(Map<String, int> counts) {
    return counts.values.fold(0, (sum, count) => sum + count);
  }

  // 计算所有年份的总数
  int _getTotalCountForAllYears(Map<int, Map<String, int>> yearlyCounts) {
    return yearlyCounts.values
        .fold(0, (sum, counts) => sum + _getTotalCountForYear(counts));
  }

  Future<void> _showAsPhoto() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('年度统计'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: _showAsPhoto,
          ),
        ],
      ),
      body: _vm.isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    '加载中...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : RepaintBoundary(
              key: _listViewKey, // 绑定 GlobalKey
              child: ValueListenableBuilder<Map<int, Map<String, int>>>(
                valueListenable: ValueNotifier(_vm.yearlyItemCounts),
                builder: (context, yearlyCounts, child) {
                  final totalCountForAllYears =
                      _getTotalCountForAllYears(yearlyCounts);

                  return ListView.builder(
                    itemCount: yearlyCounts.length,
                    itemBuilder: (context, yearIndex) {
                      var yearEntry = yearlyCounts.entries.elementAt(yearIndex);
                      var year = yearEntry.key;
                      var counts = yearEntry.value;
                      final totalCountForYear = _getTotalCountForYear(counts);
                      final yearPercentage =
                          (totalCountForYear / totalCountForAllYears * 100)
                              .toStringAsFixed(1);

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ExpansionTile(
                          title: Row(
                            children: [
                              Text(
                                '$year年',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '总数: $totalCountForYear',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          leading: _buildPercentageCircle(
                            percentage: yearPercentage,
                            color: Colors.blueAccent,
                          ),
                          children: counts.entries.map((entry) {
                            final itemPercentage =
                                (entry.value / totalCountForYear * 100)
                                    .toStringAsFixed(1);
                            final rank =
                                counts.keys.toList().indexOf(entry.key) + 1;

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Row(
                                  children: [
                                    Text(
                                      '$rank. ',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    Text(
                                      entry.key,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Text(
                                  '${entry.value}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                leading: _buildPercentageCircle(
                                  percentage: itemPercentage,
                                  color: Colors.blueAccent.withOpacity(0.6),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }

  Widget _buildPercentageCircle(
      {required String percentage, required Color color}) {
    double percent = double.parse(percentage) / 100.0;

    Color startColor = Colors.blue.shade100;
    Color endColor = color;
    Color circleColor = Color.lerp(startColor, endColor, percent)!;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: circleColor,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          '$percentage%',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: circleColor,
          ),
          overflow: TextOverflow.visible,
          softWrap: false,
        ),
      ),
    );
  }
}
