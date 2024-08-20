import 'package:count_tools/data/model/project_data.dart';
import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:count_tools/page/component/single_subproject_widget.dart';
import 'package:count_tools/page/custom_widget/remove_padding_widget.dart';
import 'package:count_tools/page/project_info_page/project_info_page_vm.dart';
import 'package:count_tools/utils/ui_utils.dart';
import 'package:count_tools/value/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectInfoPage extends StatefulWidget {
  final ProjectData parentData;

  const ProjectInfoPage({Key? key, required this.parentData}) : super(key: key);

  @override
  State<ProjectInfoPage> createState() => _ProjectInfoPageState();
}

class _ProjectInfoPageState extends State<ProjectInfoPage> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ProjectInfoViewModel(widget.parentData.id)..loadSubProjects(),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.parentData.title), actions: [_titleAction()]),
        body: Center(child: _buildProjectInfoContent()),
        floatingActionButton: _buildFloatButton(),
      ));

  Widget _titleAction() => Builder(
      builder: (context) => IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Provider.of<ProjectInfoViewModel>(context, listen: false)
                .showProjectSettingDialog(context),
          ));

  Widget _buildFloatButton() => Builder(
      builder: (context) => FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () =>
                Provider.of<ProjectInfoViewModel>(context, listen: false)
                    .addSubProjectDialog(context, widget.parentData),
          ));

  Widget _buildProjectInfoContent() => Column(children: [
        _buildProjectInfoTitle(),
        Expanded(child: _buildProjectInfoWidget()),
      ]);

  Widget _buildProjectInfoTitle() => Consumer<ProjectInfoViewModel>(
      builder: (context, model, child) => Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            "当前项目总计${model.subProjects.length}项，${model.items.length}张",
            style: AppTextStyle.heading3,
          )));

  Widget _buildProjectInfoWidget() => Consumer<ProjectInfoViewModel>(
      builder: (context, model, child) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: model.subProjects.isEmpty
              ? const Center(child: Text('没有项目，点击+添加'))
              : NonePaddingWidget(
                  context: context,
                  child: _buildProjectInfoList(
                      context,
                      model.subProjects,
                      model.ranking,
                      model.pushToSubProjectPage,
                      model.longClickSubProjectDialog,
                      model.getCountPercentage))));

  // 构建项目列表
  Widget _buildProjectInfoList(
    BuildContext context,
    List<SubProjectData> subProjects,
    List<String> ranking,
    Function(BuildContext, SubProjectData, String) pushToSubProjectPage,
    Function(BuildContext, SubProjectData) longClickSubProjectDialog,
    Function(String) getCountPercentage,) => GridView.builder(
          itemCount: subProjects.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Provider.of<ProjectInfoViewModel>(context).row,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) => SingleSubProjectWidget(
                index: ranking[index],
                name: subProjects[index].name,
                countNum: subProjects[index].count,
                color: parseColor(subProjects[index].color),
                textColor: parseColor(subProjects[index].textColor),
                countPercent: getCountPercentage(subProjects[index].count),
                showMode: Provider.of<ProjectInfoViewModel>(context).showMode,
                onLongClick: () => longClickSubProjectDialog(context, subProjects[index]),
                onClick: () => pushToSubProjectPage(context, subProjects[index], widget.parentData.id),
                width: MediaQuery.of(context).size.width / Provider.of<ProjectInfoViewModel>(context).row,
              ));
}
