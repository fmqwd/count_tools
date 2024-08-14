import 'package:count_tools/data/database/helper/item_helper.dart';
import 'package:count_tools/data/database/helper/sub_project_helper.dart';
import 'package:count_tools/data/model/item_data.dart';
import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:count_tools/page/dialog/add_item_dialog.dart';
import 'package:flutter/material.dart';

class SubProjectInfoViewModel extends ChangeNotifier {
  final ItemDBHelper itemDBHelper = ItemDBHelper();
  final SubProjectDbHelper subProjectDbHelper = SubProjectDbHelper();

  List<ItemData> _items = [];

  List<ItemData> get items => _items;

  List<String> _dates = [];

  List<String> get dates => _dates;

  Future<void> loadItems(String parentId) async {
    _items = await itemDBHelper.getByParent(parentId);
    _dates = _items.map((e) => e.date).toSet().toList();
    notifyListeners();
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
}
