import 'package:count_tools/data/database/helper/group_helper.dart';
import 'package:count_tools/data/model/group_data.dart';
import 'package:flutter/material.dart';

class GroupListPageViewModel extends ChangeNotifier {
  final GroupDBHelper groupDBHelper = GroupDBHelper();

  List<GroupData> _groupList = [];

  List<GroupData> get groupList => _groupList;
  Future<void> loadData() async {
    _groupList = await groupDBHelper.query();
    notifyListeners();
  }
}
