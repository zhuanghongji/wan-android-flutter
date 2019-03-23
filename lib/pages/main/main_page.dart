import 'package:flutter/material.dart';
import 'package:wan/pages/api/api_page.dart';
import 'package:wan/pages/main/home/home_page.dart';
import 'package:wan/pages/main/main_bottom_bar.dart';
import 'package:wan/pages/main/main_drawer.dart';
import 'package:wan/pages/main/navi/navi_page.dart';
import 'package:wan/pages/main/project/project_tree_page.dart';
import 'package:wan/pages/main/system/system_tree_page.dart';
import 'package:wan/pages/main/wx_chapter/wx_chapter_page.dart';
import 'package:wan/pages/search/search_page.dart';



/// 主页面
/// 
/// 含有五个 Tab: 首页、体系、公众号、导航、项目
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin {

  var _index = 0;
  var _pages = <Widget>[];
  var _titles = ['首页', '知识体系', '公众号', '导航', '项目'];
  var _showDrawer = true;

  Widget _getAppBarWidget(BuildContext context) {
    return AppBar(
      title: Text(_titles[_index]),
      elevation: 0.4,
      actions: _getActionWidgets(),
    );
  }

  List<Widget> _getActionWidgets() {
    return _showDrawer ? [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          _onSearchPress();
        },
      ),
    ] : null;
  }

  void _onSearchPress() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SearchPage();
      }
    ));
  }

  void _onTabChanged(int newValue) {
    setState(() {
      _index = newValue;
      _showDrawer = _index == 0;
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('温馨提示'),
        content: Text('确定退出应用？'),
        actions: <Widget>[
          FlatButton(
            child: Text('再看一会'),
            onPressed: () => { Navigator.of(context).pop(false) },
          ),
          FlatButton(
            child: Text('退出'),
            onPressed: () => { Navigator.of(context).pop(true) },
          )
        ],
      )
    );
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      SystemTreePage(),
      WxChapterPage(),
      NaviPage(),
      ProjectTreePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: DefaultTabController(
        length: _pages.length,
        child: Scaffold(
          appBar: _getAppBarWidget(context),
          drawer: _showDrawer ? MainDrawer() : null,
          body: IndexedStack(
            index: _index,
            children: _pages,
          ),
          bottomNavigationBar: MainBottomNavigationBar(
            index: _index,
            onChanged: _onTabChanged,
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}