import 'package:count_tools/data/database/helper/activity_helper.dart';
import 'package:count_tools/data/model/activity_data.dart';
import 'package:flutter/material.dart';

class ActivityListPageViewModel extends ChangeNotifier {
  final ActivityDBHelper activityDBHelper = ActivityDBHelper();

  List<ActivityData> _activityData = [];
  List<ActivityData> get activityData => _activityData;

  Future<void> loadData() async {
    _activityData = await activityDBHelper.query();
    notifyListeners();
  }
}
