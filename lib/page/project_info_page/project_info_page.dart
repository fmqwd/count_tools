import 'package:count_tools/data/model/project_data.dart';
import 'package:count_tools/page/component/singe_item_widget.dart';
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
            appBar: AppBar(title: Text(widget.parentData.title)),
            body: Center(child: _buildProjectInfoContent()),
            floatingActionButton: Builder(
              builder: (context) => FloatingActionButton(
                onPressed: () => Provider.of<ProjectInfoViewModel>(context, listen: false).
                addSubProjectDialog(context,widget.parentData),
                child: const Icon(Icons.add),
              ),
            )),
      );

  Widget _buildProjectInfoContent() => Column(children: [
        _buildProjectInfoTitle(),
        Expanded(child: _buildProjectInfoList())
      ]);

  Widget _buildProjectInfoTitle() => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        alignment: Alignment.center,
        child: Consumer<ProjectInfoViewModel>(
          builder: (context, model, child) => Text(
            "当前项目总计${model.subProjects.length}项，${model.items.length}张",
            style: AppTextStyle.heading3,
          ),
        ),
      );

  Widget _buildProjectInfoList({int line = 5}) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Consumer<ProjectInfoViewModel>(builder: (context, model, child) {
        if (model.subProjects.isEmpty) {
          return const Center(child: Text('没有项目，点击+添加'));
        }
        return MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: line,
              childAspectRatio:1,
            ),
            itemCount: model.subProjects.length,
            itemBuilder: (context, index) => SingleItemWidget(
              width: MediaQuery.of(context).size.width / line,
              countPercent: model.getCountPercentage(model.subProjects[index].count),
              countNum: model.subProjects[index].count,
              name: model.subProjects[index].name,
              color: parseColor(model.subProjects[index].color),
              textColor: parseColor(model.subProjects[index].textColor),
              onClick: () => model.pushToSubProjectPage(context, model.subProjects[index],widget.parentData.id),
            ),
          ),
        );
      }));
}
