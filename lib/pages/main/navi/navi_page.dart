import 'package:flutter/material.dart';

import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/navi.dart';
import 'package:wan/api/datas/navi_article.dart';
import 'package:wan/router/w_router.dart';

/// 导航页面
class NaviPage extends StatefulWidget {
  @override
  _NaviPageState createState() => _NaviPageState();
}

class _NaviPageState extends State<NaviPage> {
  List<Navi> _navis = [];

  Future<void> _getNavis() async {
    ApiService.getNavis().then((List<Navi> navis) {
      setState(() {
        _navis.clear();
        _navis.addAll(navis);
      });
    });
  }

  void _onNaviArticlePressed(NaviArticle article) {
    WRouter.pushWebPage(context, article.title, article.link);
  }

  /// 构建每一个 SystemTree
  Widget _buildNaviItem(BuildContext context, int index) {
    if (index >= _navis.length) {
      return null;
    }
    var navi = _navis[index];
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              navi.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: _buildArticles(navi.articles),
          )
        ],
      ),
    );
  }

  /// 构建 Navi 下的 [articles]
  Widget _buildArticles(List<NaviArticle> articles) {
    Widget result;
    List<Widget> chips = [];
    for (var article in articles) {
      chips.add(RawChip(
        onPressed: () { _onNaviArticlePressed(article); },
        label: Text(article.title),
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
    _getNavis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getNavis,
        child: ListView.separated(
          itemBuilder: _buildNaviItem,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 0.5,
              color: Colors.black26,
            );
          },
          itemCount: _navis.length,
        ),
      ),
    );
  }
}