import 'package:flutter/material.dart';

import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/article.dart';
import 'package:wan/api/datas/articles.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/base/base_page.dart';
import 'package:wan/router/w_router.dart';
import 'package:wan/utils/time_line.dart';
import 'package:wan/widget/loading_item.dart';


/// 知识体系具体分支下的文章列表页面
class SystemArticlesPage extends BasePage {
  final String title;
  final int cid;

  SystemArticlesPage({ this.title, this.cid });

  @override
  BasePageState<BasePage> getPageState() => _SystemArticlesPageState();
}

class _SystemArticlesPageState extends BasePageState<SystemArticlesPage> {
  /// 页码（文章）
  int _pageNum = 0;
  /// 文章列表
  List<Article> _articles = [];

  LoadingType _loadingType = LoadingType.loading;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    showContent();
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

  _setupLoadingType(LoadingType type) {
    setState(() {
      _loadingType = type;
    });
  }

  /// 根据体系 id 来获取对应文章列表
  Future<void> _getArticlesByCid() async {
    _setupLoadingType(LoadingType.loading);
    _pageNum = 0;
    ApiService.getArticlesByCid(_pageNum, widget.cid).then((Articles articles) {
      setState(() {
        _articles.clear();
        _articles.addAll(articles.datas);
        var allLoaded = _articles.length >= articles.total;
        _setupLoadingType(allLoaded ? LoadingType.allLoaded : LoadingType.normal);
      });
    });
  }

  /// 根据体系 id 来获取更多文章列表
  void _moreArticlesByCid() {
    _setupLoadingType(LoadingType.loading);
    _pageNum++;
    ApiService.getArticlesByCid(_pageNum, widget.cid).then((Articles articles) {
      setState(() {
        _articles.addAll(articles.datas);
        var allLoaded = _articles.length >= articles.total;
        _setupLoadingType(allLoaded ? LoadingType.allLoaded : LoadingType.normal);
      });
    });
  }

  Widget _buildArticleItem(BuildContext context, int index) {
    // 文章
    if (index < _articles.length) {
      var article =_articles[index];
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

    return LoadingItem(_loadingType);
  }

  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text(widget.title),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return RefreshIndicator(
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
    );
  }
}