import 'package:count_tools/data/database/helper/item_helper.dart';
import 'package:count_tools/data/database/helper/project_helper.dart';
import 'package:count_tools/data/database/helper/sub_project_helper.dart';
import 'package:count_tools/data/model/project_data.dart';
import 'package:count_tools/page/dialog/add_project_dialog.dart';
import 'package:count_tools/page/dialog/del_project_dialog.dart';
import 'package:count_tools/page/dialog/edit_project_dialog.dart';
import 'package:count_tools/page/project_info_page/project_info_page.dart';
import 'package:count_tools/page/setting_page/setting_page.dart';
import 'package:count_tools/utils/route_utils.dart';
import 'package:count_tools/utils/setting_utils.dart';
import 'package:flutter/material.dart';

class HomePageViewModel extends ChangeNotifier {
  final ProjectDBHelper projectHelper = ProjectDBHelper();
  final SubProjectDbHelper subProjectDbHelper = SubProjectDbHelper();
  final ItemDBHelper itemDBHelper = ItemDBHelper();

  List<ProjectData> _projects = [];

  List<ProjectData> get projects => _projects;

  Future<List<ProjectData>> loadProjects() async {
    _projects = await projectHelper.get();
    notifyListeners();
    return projects;
  }

  Future<void> addProject(ProjectData data) async {
    await loadProjects();
    await projectHelper.insert(data);
    await loadProjects();
  }

  Future<void> editProject(ProjectData data) async {
    await loadProjects();
    await projectHelper.update(data);
    await loadProjects();
  }

  Future<void> deleteProject(String id) async {
    await loadProjects();
    await projectHelper.delete(id);
    await subProjectDbHelper.deleteByParent(id);
    await itemDBHelper.deleteByProject(id);
    await loadProjects();
  }

  // 跳转项目详情
  pushProjectInfoPage(BuildContext context, ProjectData data) async {
    int row = await SettingUtils.getProjectInfoRowNum();
    String order = await SettingUtils.getProjectInfoSort();
    String criteria = await SettingUtils.getProjectInfoSortType();
    String showType = await SettingUtils.getShowMode();
    if (context.mounted) {
      return RouteUtils.pushAnim(
          context,
          ProjectInfoPage(
              parentData: data,
              order: order,
              criteria: criteria,
              showType: showType));
    }
  }

  // 跳转设置页
  pushSetPage(BuildContext context) {
    return RouteUtils.pushAnim(context, const SettingPage());
  }

  // 跳转添加项目弹窗
  addProjectDialog(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext dialogContext) =>
          buildAddProjectDialog(context, dialogContext));

  // 跳转删除项目弹窗
  delProjectDialog(BuildContext context, String projectId) => showDialog(
      context: context,
      builder: (BuildContext dialogContext) =>
          buildDelProjectDialog(context, dialogContext, projectId));

  // 跳转编辑项目弹窗
  editProjectDialog(BuildContext context, ProjectData data) => showDialog(
      context: context,
      builder: (BuildContext dialogContext) =>
          buildEditProjectDialog(context, dialogContext, data));
}
