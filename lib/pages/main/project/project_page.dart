import 'package:flutter/material.dart';
import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/project_tree.dart';
import 'package:wan/assets/images.dart';

/// 项目页面
class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  List<ProjectTree> _projectTrees = [];

  /// 获取项目分类
  void _getProjects() {
    ApiService.getProjects().then((List<ProjectTree> projectTrees) {
      setState(() {
        _projectTrees.clear();
        _projectTrees.addAll(projectTrees);
      });
    });
  }

  void _onProjectTreeItemPressed(ProjectTree projectTree) {
    print(projectTree);
  }

  List<Widget> _buildProjectTreeItems(List<ProjectTree> projectTrees) {
    List<Widget> chips = [];
    for (var projectTree in projectTrees) {
      chips.add(RawChip(
        onPressed: () { _onProjectTreeItemPressed(projectTree); },
        label: Text(
          projectTree.name,
          style: TextStyle(fontSize: 18),
        ),
        avatar: Image.asset(ImageAsset.icWoman),
      ));
    }
    return chips;
  }

  @override
  void initState() {
    super.initState();
    _getProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Center(
            child: Column(
              children: _buildProjectTreeItems(_projectTrees),
            ),
          ),
        ),
      ),
    );
  }
}