import 'package:count_tools/data/database/helper/item_helper.dart';
import 'package:count_tools/data/database/helper/sub_project_helper.dart';
import 'package:count_tools/data/model/item_data.dart';
import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:count_tools/page/dialog/add_item_dialog.dart';
import 'package:count_tools/page/dialog/subproject_info_setting_dialog.dart';
import 'package:count_tools/utils/safe_utils.dart';
import 'package:count_tools/utils/setting_utils.dart';
import 'package:flutter/material.dart';

class SubProjectInfoViewModel extends ChangeNotifier {
  final ItemDBHelper itemDBHelper = ItemDBHelper();
  final SubProjectDbHelper subProjectDbHelper = SubProjectDbHelper();

  List<ItemData> _items = [];
  List<ItemData> get items => _items;

  List<String> _dates = [];
  List<String> get dates => _dates;

  String _cost = '';
  String get cost => _cost;

  bool _isShowPrice = true;
  bool get isShowPrice => _isShowPrice;

  bool _isQuickAdd = false;
  bool get isQuickAdd => _isQuickAdd;

  Future<void> loadItems(String parentId) async {
    await _loadShared();
    _items = await itemDBHelper.getByParent(parentId);
    _dates = _items.map((e) => e.date).toSet().toList();
    if (_isShowPrice) loadCost();
    notifyListeners();
  }

  Future<void> _loadShared() async {
    _isShowPrice = await SettingUtils.getIsShowTotalPrice();
    _isQuickAdd = await SettingUtils.getIsQuickAdd();
    notifyListeners();
  }

  void loadCost() {
    double mCost = 0.0;
    for (ItemData item in items) {
      mCost += safeDouble(item.price);
    }
    _cost = mCost.toString();
  }

  Future<void> addItem(ItemData data) async {
    await itemDBHelper.insert(data);
    await loadItems(data.parentId);
  }

  Future<void> addItems(List<ItemData> datas) async {
    await itemDBHelper.insertAll(datas);
    await loadItems(datas.first.parentId);
  }

  Future<void> editItem(ItemData data) async {
    await itemDBHelper.update(data);
    await loadItems(data.parentId);
  }

  Future<void> editItems(List<ItemData> datas) async {
    await itemDBHelper.updateAll(datas);
    await loadItems(datas.first.parentId);
  }

  Future<void> deleteItem(String id) async {
    await itemDBHelper.delete(id);
    await loadItems(id);
  }

  Future<void> updateSubProject(SubProjectData data) async {
    await loadItems(data.id);
    SubProjectData dataUpdate = data.copyWith(count: (items.length).toString());
    await subProjectDbHelper.update(dataUpdate);
  }

  addItemDialog(BuildContext context, SubProjectData data, String id) =>
      showDialog(
          context: context,
          builder: (BuildContext dialogContext) =>
              buildAddItemDialog(context, dialogContext, data, id));

  showSettingDialog(BuildContext context) =>
      showSubProjectInfoSettingDialog(context, () => _loadShared());
}
