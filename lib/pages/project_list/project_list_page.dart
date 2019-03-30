import 'package:flutter/material.dart';
import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/project.dart';
import 'package:wan/api/datas/projects.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/base/base_page.dart';
import 'package:wan/router/w_router.dart';
import 'package:wan/utils/time_line.dart';
import 'package:wan/widget/loading_item.dart';

/// 项目列表页面
class ProjectListPage extends BasePage {
  final String projectTreeName;
  final int projectTreeId;

  ProjectListPage({ this.projectTreeName, this.projectTreeId });

  @override
  _ProjectListPageState createState() => _ProjectListPageState();

  @override
  BasePageState<BasePage> getPageState()  => _ProjectListPageState();
}

class _ProjectListPageState extends BasePageState<ProjectListPage> {
  /// 页码（文章）
  int _pageNum = 0;
  /// 项目列表
  List<Project> _projects = [];

  LoadingType _loadingType = LoadingType.loading;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    showContent();
    _getProjectsByCid();
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _moreProjectsByCid();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

   _setupLoadingType(LoadingType type) {
    setState(() {
      _loadingType = type;
    });
  }

  /// 根据项目分类 id 来获取项目列表
  Future<void> _getProjectsByCid() async {
    _setupLoadingType(LoadingType.loading);
    _pageNum = 1;
    ApiService.getProjectsByCid(_pageNum, widget.projectTreeId).then((Projects projects) {
      setState(() {
        _projects.clear();
        _projects.addAll(projects.datas);
        var allLoaded = _projects.length >= projects.total;
        _setupLoadingType(allLoaded ? LoadingType.allLoaded : LoadingType.normal);
      });
    });
  }

  /// 根据项目分类 id 来获取项目列表
  void _moreProjectsByCid() {
    _setupLoadingType(LoadingType.loading);
    _pageNum++;
    ApiService.getProjectsByCid(_pageNum, widget.projectTreeId).then((Projects projects) {
      setState(() {
        _projects.addAll(projects.datas);
        var allLoaded = _projects.length >= projects.total;
        _setupLoadingType(allLoaded ? LoadingType.allLoaded : LoadingType.normal);
      });
    });
  }

  Widget _buildProjectItem(BuildContext context, int index) {
    // 文章
    if (index < _projects.length) {
      var project =_projects[index];
      return InkWell(
        onTap: () {
          WRouter.gotoWebPage(context, project.title, project.link);
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    ImageAsset.icMan,
                    width: 16,
                    height: 16,
                  ),
                  Text('  '),
                  Text(
                    project.author,
                    style:TextStyle(fontSize: 14),
                    textAlign: TextAlign.start,
                  ),
                  Expanded(
                    child: Text(
                      TimelineUtil.format(project.publishTime),
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                        project.title,
                        maxLines: 2,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: <Widget>[
                  Text(project.superChapterName,
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    return LoadingItem(_loadingType);
  }

  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text(widget.projectTreeName),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _getProjectsByCid,
        child: ListView.separated(
          itemBuilder: _buildProjectItem,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 0.5,
              color: Colors.black26,
            );
          },
          itemCount: _projects.length + 1,
          controller: _scrollController,
        ),
      );
  }
}