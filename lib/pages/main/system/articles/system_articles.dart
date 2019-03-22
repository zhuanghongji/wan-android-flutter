import 'package:flutter/material.dart';

import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/article.dart';
import 'package:wan/api/datas/articles.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/pages/web/web_page.dart';
import 'package:wan/utils/time_line.dart';

void gotoSystemArticlesPage(BuildContext context, String title, int cid) async {
  await Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return SystemArticlesPage(title: title, cid: cid);
  }));
}

/// 知识体系下的文章列表
class SystemArticlesPage extends StatefulWidget {
  final String title;
  final int cid;

  SystemArticlesPage({ this.title, this.cid });

  @override
  _SystemArticlesPageState createState() => _SystemArticlesPageState();
}

class _SystemArticlesPageState extends State<SystemArticlesPage> {
  /// 页码（文章）
  int _pageNum = 0;
  /// 文章列表
  List<Article> _articles = [];

  ScrollController _scrollController = ScrollController();

  Future<void> _getArticlesByCid() async {
    _pageNum = 0;
    ApiService.getArticlesByCid(_pageNum, widget.cid).then((Articles articles) {
      setState(() {
        _articles.clear();
        _articles.addAll(articles.datas);
      });
    });
  }

  void _moreArticlesByCid() {
    _pageNum++;
    ApiService.getArticlesByCid(_pageNum, widget.cid).then((Articles articles) {
      setState(() {
        _articles.addAll(articles.datas);
      });
    });
  }

  Widget _buildArticleItem(BuildContext context, int index) {
    // 文章
    if (index < _articles.length) {
      var article =_articles[index];
      return InkWell(
        onTap: () {
          gotoWebPage(context, article.title, article.link);
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
                    article.author,
                    style:TextStyle(fontSize: 14),
                    textAlign: TextAlign.start,
                  ),
                  Expanded(
                    child: Text(
                      TimelineUtil.format(article.publishTime),
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
                        article.title,
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
                  Text(article.superChapterName,
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

    // 加载更多
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getArticlesByCid();
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _moreArticlesByCid();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: _getArticlesByCid,
        child: ListView.separated(
          itemBuilder: _buildArticleItem,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 0.5,
              color: Colors.black26,
            );
          },
          itemCount: _articles.length + 1,
          controller: _scrollController,
        ),
      ),
    );
  }
}