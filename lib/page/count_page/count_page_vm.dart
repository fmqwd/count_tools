import 'package:count_tools/data/database/helper/sub_project_helper.dart';
import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:count_tools/utils/safe_utils.dart';
import 'package:count_tools/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class CountPageViewModel extends ChangeNotifier {
  CountPageViewModel(this.projectId);

  final String projectId;
  final SubProjectDbHelper subProjectDbHelper = SubProjectDbHelper();

  List<SubProjectData> _subProjects = [];
  List<SubProjectData> get subProjects => _subProjects;

  Map<Color, int> _colorData = {};
  Map<Color, int> get colorData => _colorData;

  int _countNum = 0;
  int get countNum => _countNum;

  Future<void> loadDatas() async {
    _subProjects = await subProjectDbHelper.getByParent(projectId);
    await loadColorData();
    await loadCountData();
    notifyListeners();
  }

  Future<void> loadColorData() async {
    Map<Color, int> mColorData = {};
    for (var subProject in _subProjects) {
      var mColor = parseColor(subProject.color);
      mColorData[mColor] = (mColorData[mColor] ?? 0) + 1;
    }
    _colorData = mColorData;
    notifyListeners();
  }

  Future<void> loadCountData() async {
    for (var e in _subProjects) {
      _countNum = _countNum + safeInt(e.count);
    }
  }
}
