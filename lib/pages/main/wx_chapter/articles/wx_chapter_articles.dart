import 'package:flutter/material.dart';

import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/wx_article.dart';
import 'package:wan/api/datas/wx_article_s.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/router/w_router.dart';
import 'package:wan/utils/time_line.dart';


/// 微信公众号对应的文章列表页面
class WxChapterArticlesPage extends StatefulWidget {
  final String chapterName;
  final int chapterId;

  WxChapterArticlesPage({ this.chapterName, this.chapterId });

  @override
  _WxChapterArticlesPageState createState() => _WxChapterArticlesPageState();
}

class _WxChapterArticlesPageState extends State<WxChapterArticlesPage> {
  /// 页码（文章）
  int _pageNum = 0;
  /// 文章列表
  List<WxArticle> _wxArticles = [];

  ScrollController _scrollController = ScrollController();

  Future<void> _getWxArticles() async {
    _pageNum = 0;
    ApiService.getWxArticles(widget.chapterId, _pageNum).then((WxArticles wxArticles) {
      setState(() {
        _wxArticles.clear();
        _wxArticles.addAll(wxArticles.datas);
      });
    });
  }

  void _moreWxArticles() {
    _pageNum++;
    ApiService.getWxArticles(widget.chapterId, _pageNum).then((WxArticles wxArticles) {
      setState(() {
        _wxArticles.addAll(wxArticles.datas);
      });
    });
  }

  Widget _buildWxArticleItem(BuildContext context, int index) {
    // 文章
    if (index < _wxArticles.length) {
      var article =_wxArticles[index];
      return InkWell(
        onTap: () {
          WRouter.gotoWebPage(context, article.title, article.link);
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
    _getWxArticles();
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _moreWxArticles();
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
        title: Text(widget.chapterName),
      ),
      body: RefreshIndicator(
        onRefresh: _getWxArticles,
        child: ListView.separated(
          itemBuilder: _buildWxArticleItem,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 0.5,
              color: Colors.black26,
            );
          },
          itemCount: _wxArticles.length + 1,
          controller: _scrollController,
        ),
      ),
    );
  }
}