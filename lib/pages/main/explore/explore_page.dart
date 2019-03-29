import 'package:flutter/material.dart';

import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/project_tree.dart';
import 'package:wan/api/datas/wx_chapter.dart';
import 'package:wan/router/w_router.dart';


/// 项目树页面
class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<ProjectTree> _projectTrees = [];
  List<WxChapter> _wxChapters = [];

  /// 获取项目分类
  void _getProjects() {
    ApiService.getProjectTrees().then((List<ProjectTree> projectTrees) {
      setState(() {
        _projectTrees.clear();
        _projectTrees.addAll(projectTrees);
      });
    });
  }

  /// 获取公众号列表
  void _getWxChapters() {
    ApiService.getWxChapters().then((List<WxChapter> wxChapters) {
      setState(() {
        _wxChapters.clear();
        _wxChapters.addAll(wxChapters);
      });
    });
  }

  void _onProjectTreeItemPressed(ProjectTree projectTree) {
    print(projectTree);
    WRouter.gotoProjectListPage(context, projectTree.name, projectTree.id);
  }

  void _onWxChapterItemPressed(WxChapter chapter) {
    print(chapter);
    WRouter.gotoWxChapterArticlesPage(context, chapter.name, chapter.id);
  }

  Widget _buildTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(0, 0, 16, 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildProjectTree(List<ProjectTree> projectTrees) {
    Widget result;
    List<Widget> chips = [];
    for (var projectTree in projectTrees) {
      chips.add(RawChip(
        onPressed: () { _onProjectTreeItemPressed(projectTree); },
        label: Text(projectTree.name),
      ));
    }
    result = Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      alignment: WrapAlignment.start,
      children: chips,
    );
    return result;
  }

  Widget _buildWxChapters(List<WxChapter> wxChapters) {
    Widget result;
    List<Widget> chips = [];
    for (var wxChapter in wxChapters) {
      chips.add(RawChip(
        onPressed: () { _onWxChapterItemPressed(wxChapter); },
        label: Text(wxChapter.name),
      ));
    }
    result = Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      alignment: WrapAlignment.start,
      children: chips,
    );
    return result;
  }

  @override
  void initState() {
    super.initState();
    _getProjects();
    _getWxChapters();
  }

  @override
  Widget build(BuildContext context) {
    var divider = Container(
      height: 24,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Center(
            child: Column(
              children: <Widget>[
                _projectTrees.isEmpty ? _buildTitle('') : _buildTitle('项目'),
                _buildProjectTree(_projectTrees),
                divider,
                _wxChapters.isEmpty ? _buildTitle('') : _buildTitle('微信公众号'),
                _buildWxChapters(_wxChapters),
              ]
            ),
          ),
        ),
      ),
    );
  }
}