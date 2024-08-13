import 'package:count_tools/data/database/helper/item_helper.dart';
import 'package:count_tools/data/database/helper/project_helper.dart';
import 'package:count_tools/data/database/helper/sub_project_helper.dart';
import 'package:count_tools/data/model/item_data.dart';
import 'package:count_tools/data/model/project_data.dart';
import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:count_tools/page/dialog/add_subproject_dialog.dart';
import 'package:count_tools/page/subproject_info_page/subproject_info_page.dart';
import 'package:count_tools/utils/route_utils.dart';
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

  Future<void> loadSubProjects() async {
    _subProjects = await subProjectDbHelper.getByParent(parentId);
    _subProjects = sortSubProjectData(_subProjects);
    _items = await itemDBHelper.getByProject(parentId);
    notifyListeners();
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
    await loadSubProjects();
  }

  Future<void> updateProjectCount(ProjectData parentData) async {
    await projectDBHelper.update(parentData.copyWith(
      count: (subProjects.length).toString(),
    ));
  }

  String getCountPercentage(String count) {
    if (count == '0') {
      return '0.0%';
    }
    int total = int.parse(count);
    int done = items.length;
    return '${(total / done * 100).toStringAsFixed(2)}%';
  }

  List<SubProjectData> sortSubProjectData(List<SubProjectData> subProject,
          {bool isDesc = true}) =>
      subProject.toList()
        ..sort((a, b) => (int.parse(isDesc ? b.count : a.count))
            .compareTo(int.parse(isDesc ? a.count : b.count)));

  pushToSubProjectPage(BuildContext context, SubProjectData data, String projectId) =>
      RouteUtils.pushAnim(context, SubProjectInfoPage(parentData: data, projectId: projectId));

  addSubProjectDialog(BuildContext context, ProjectData data) => showDialog(
      context: context,
      builder: (BuildContext dialogContext) =>
          AddSubProjectDialog(extContext: context, parentData: data));
}
