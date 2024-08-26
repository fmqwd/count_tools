import 'package:count_tools/data/database/helper/item_helper.dart';
import 'package:count_tools/data/database/helper/project_helper.dart';
import 'package:count_tools/data/database/helper/sub_project_helper.dart';
import 'package:count_tools/data/model/item_data.dart';
import 'package:count_tools/data/model/project_data.dart';
import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:count_tools/page/count_page/count_page.dart';
import 'package:count_tools/page/dialog/add_subproject_dialog.dart';
import 'package:count_tools/page/dialog/long_click_subproject_dialog.dart';
import 'package:count_tools/page/dialog/project_info_setting_dialog.dart';
import 'package:count_tools/page/subproject_info_page/subproject_info_page.dart';
import 'package:count_tools/utils/route_utils.dart';
import 'package:count_tools/utils/safe_utils.dart';
import 'package:count_tools/utils/setting_utils.dart';
import 'package:flutter/material.dart';

class ProjectInfoViewModel extends ChangeNotifier {
  ProjectInfoViewModel(this.parentId);

  final String parentId;

  final SubProjectDbHelper subProjectDbHelper = SubProjectDbHelper();
  final ProjectDBHelper projectDBHelper = ProjectDBHelper();
  final ItemDBHelper itemDBHelper = ItemDBHelper();

  List<SubProjectData> _subProjects = [];
  List<SubProjectData> get subProjects => _subProjects;

  List<ItemData> _items = [];
  List<ItemData> get items => _items;

  List<String> _ranking = [];
  List<String> get ranking => _ranking;

  int _row = 5;
  int get row => _row;

  bool _isDesc = true;
  bool get isDesc => _isDesc;

  String _showMode = "";
  String get showMode => _showMode;

  Future<void> loadSubProjects() async {
    await loadShared();
    _items = await itemDBHelper.getByProject(parentId);
    _subProjects = await subProjectDbHelper.getByParent(parentId);
    _subProjects = sortSubProjectData(_subProjects);
    await loadRanking();
    notifyListeners();
  }

  Future<void> loadShared() async {
    _showMode = await SettingUtils.getShowMode();
    _isDesc = await SettingUtils.getProjectInfoSort() == '降序';
    _row = await SettingUtils.getProjectInfoRowNum();
  }

  Future<void> loadRanking() async {
    List<int> nums = _subProjects.map((e) => safeInt(e.count)).toList();
    _ranking = getRanks(nums).map((e) => e.toString()).toList();
  }

  Future<void> addSubProject(data, parentData) async {
    await subProjectDbHelper.insert(data);
    await loadSubProjects();
    await updateProjectCount(parentData);
  }

  Future<void> editSubProject(SubProjectData data) async {
    await subProjectDbHelper.update(data);
    await loadSubProjects();
  }

  Future<void> deleteSubProject(String id) async {
    await subProjectDbHelper.delete(id);
    await itemDBHelper.deleteByParent(id);
    await loadSubProjects();
  }

  Future<void> updateProjectCount(ProjectData parentData) async =>
      await projectDBHelper.update(parentData.copyWith(
        count: (subProjects.length).toString(),
      ));

  List<int?> getRanks(List<int> numbers) {
    final rankedMap = <int, int>{};
    int rank = 1;
    for (int i = 0; i < numbers.length; i++) {
      if (i == 0 || numbers[i] != numbers[i - 1]) {
        rankedMap[numbers[i]] = rank;
        rank++;
      } else {
        rankedMap[numbers[i]] = rank - 1;
      }
    }
    return numbers.map((number) => rankedMap[number]).toList();
  }

  String getCountPercentage(String count) {
    if (count == '0') {
      return '0.0%';
    }
    int total = safeInt(count);
    int done = items.length;
    return '${(total / done * 100).toStringAsFixed(2)}%';
  }

  List<SubProjectData> sortSubProjectData(List<SubProjectData> subProject) =>
      subProject.toList()
        ..sort((a, b) => (safeInt(isDesc ? b.count : a.count))
            .compareTo(safeInt(isDesc ? a.count : b.count)));

  pushToSubProjectPage(BuildContext context, SubProjectData data, String id) =>
      RouteUtils.pushAnim(context, SubProjectInfoPage(parentData: data, projectId: id));

  pushToCountPage(BuildContext context, String id) =>
      RouteUtils.pushAnim(context, CountPage(id: id));

  addSubProjectDialog(BuildContext context, ProjectData data) => showDialog(
      context: context,
      builder: (BuildContext dialogContext) =>
          AddSubProjectDialog(extContext: context, parentData: data));

  longClickSubProjectDialog(BuildContext context, SubProjectData data) =>
      showDialog(
          context: context,
          builder: (BuildContext dialogContext) =>
              LongClickSubProjectDialog(extContext: context, data: data));

  showProjectSettingDialog(BuildContext context) =>
      showProjectInfoSettingDialog(context, () => loadSubProjects());
}
