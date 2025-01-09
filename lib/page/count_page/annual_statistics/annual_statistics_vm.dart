import 'package:count_tools/data/database/helper/item_helper.dart';
import 'package:count_tools/data/model/item_data.dart';
import 'package:count_tools/utils/log.dart';
import 'package:flutter/material.dart';

class AnnualStatisticsViewModel with ChangeNotifier {
  final ItemDBHelper _itemDBHelper = ItemDBHelper();
  List<ItemData> _items = [];
  final Map<int, Map<String, int>> _yearlyItemCounts = {};
  bool _isLoading = true;

  List<ItemData> get items => _items;
  Map<int, Map<String, int>> get yearlyItemCounts => _yearlyItemCounts;
  bool get isLoading => _isLoading;

  Future<void> loadData() async {
    try {
      _isLoading = true;
      notifyListeners();

      _items = await _itemDBHelper.get();
      calculateYearlyItemCounts();
    } catch (e) {
      Log.e('loadData', 'Error loading data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void calculateYearlyItemCounts() {
    _yearlyItemCounts.clear();

    for (var item in _items) {
      try {
        DateTime date = DateTime.parse(item.date);
        int year = date.year;
        _yearlyItemCounts.putIfAbsent(year, () => {});

        _yearlyItemCounts[year]![item.itemName] =
            (_yearlyItemCounts[year]![item.itemName] ?? 0) + 1;
      } catch (_) {
        continue;
      }
    }

    _yearlyItemCounts.forEach((year, counts) {
      _yearlyItemCounts[year] = Map.fromEntries(
          counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value))
      );
    });
  }
}