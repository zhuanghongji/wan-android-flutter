import 'package:flutter/material.dart';

import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/system.dart';
import 'package:wan/api/datas/system_tree.dart';

import 'package:wan/router/w_router.dart';


/// 知识体系树页面
class SystemTreePage extends StatefulWidget {
  @override
  _SystemTreePageState createState() => _SystemTreePageState();
}

class _SystemTreePageState extends State<SystemTreePage> {
  List<SystemTree> _systemTrees = [];

  /// 获取知识体系树数据
  Future<void> _getSystemTrees() async {
    ApiService.getSystemTrees().then((List<SystemTree> systemTrees) {
      setState(() {
        _systemTrees.clear();
        _systemTrees.addAll(systemTrees);
      });
    });
  }

  void _onSystemBranchPressed(System branch) {
    print(branch);
    WRouter.gotoSystemArticlesPage(context, branch.name, branch.id);
  }

  /// 构建每一个 SystemTree
  Widget _buildSystemTreeItem(BuildContext context, int index) {
    if (index >=_systemTrees.length) {
      return null;
    }
    var systemTree =_systemTrees[index];
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              systemTree.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: buildChildren(systemTree.children),
          )
        ],
      ),
    );
  }

  /// 构建 SystemTree 下的 [children]
  Widget buildChildren(List<System> children) {
    Widget result;
    List<Widget> chips = [];
    for (var branch in children) {
      chips.add(RawChip(
        onPressed: () { _onSystemBranchPressed(branch); },
        label: Text(branch.name),
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
    _getSystemTrees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getSystemTrees,
        child: ListView.separated(
          itemBuilder: _buildSystemTreeItem,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 0.5,
              color: Colors.black26,
            );
          },
          itemCount: _systemTrees.length,
        ),
      ),
    );
  }
}