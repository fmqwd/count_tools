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

  Future<void> loadItems(String parentId) async {
    _items = await itemDBHelper.get();
    notifyListeners();
  }

  Future<void> addItem(ItemData data) async {
    await itemDBHelper.insert(data);
    await loadItems(data.parentId);
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
    loadItems(data.id);
    SubProjectData dataUpdate = data.copyWith(count: (items.length).toString());
    await subProjectDbHelper.update(dataUpdate);
  }

  addItemDialog(
    BuildContext context,
    SubProjectData parentData,
    String projectId,
  ) =>
      showDialog(
          context: context,
          builder: (BuildContext dialogContext) => buildAddItemDialog(
              context, dialogContext, parentData, projectId));
}
