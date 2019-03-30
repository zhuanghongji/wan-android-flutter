import 'package:flutter/material.dart';

import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/article.dart';
import 'package:wan/api/datas/articles.dart';
import 'package:wan/api/datas/banner.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/pages/main/main_drawer.dart';
import 'package:wan/router/w_router.dart';
import 'package:wan/utils/time_line.dart';
import 'package:wan/widget/custom_banner.dart';
import 'package:wan/widget/loading_item.dart';

/// 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  /// 轮播图数据列表
  List<BannerItem> _bannerItems = [];
  /// 文章列表
  List<Article> _articles = [];

  LoadingType _loadingType = LoadingType.loading;
  ScrollController _scrollController = ScrollController();

  /// 页码（文章）
  int _pageNum = 0;

  @override
  void initState() {
    super.initState();
    _getBannerItems();
    _getArticles();
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _getMoreArticles();
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

  /// 获取轮播图数据 
  void _getBannerItems() {
    ApiService.getBanner().then((List<BannerItem> bannerItems) {
      setState(() {
        _bannerItems = bannerItems;
      });
    });
  }

  /// 获取文章
  Future<void> _getArticles() async {
    _setupLoadingType(LoadingType.loading);
    _pageNum = 0;
    ApiService.getArticles(_pageNum).then((Articles articles){
      setState(() {
        _articles.addAll(articles.datas);
        var allLoaded = _articles.length >= articles.total;
        _setupLoadingType(allLoaded ? LoadingType.allLoaded : LoadingType.normal);
      });
    });
  }

  /// 获取更多文章 
  void _getMoreArticles() {
    _setupLoadingType(LoadingType.loading);
    _pageNum++;
    ApiService.getArticles(_pageNum).then((Articles articles){
      setState(() {
        _articles.addAll(articles.datas);  
        var allLoaded = _articles.length >= articles.total;
        _setupLoadingType(allLoaded ? LoadingType.allLoaded : LoadingType.normal);
      });
    });
  }

  void _onBannerItemTap(BannerItem item, int index) {
    print('_onBannerItemTap: item = $item, index = $index');
    WRouter.gotoWebPage(context, item.title, item.url);
  }

  Widget _buildArticleItem(BuildContext context, int index) {
    // 轮播图
    if (index == 0) {
      return Container(
        height: 200,
        color: Colors.purple,
        child: CustomBanner(_bannerItems, _onBannerItemTap),
      );
    }

    // 文章
    if (index < _articles.length + 1) {
      var article =_articles[index - 1];
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getArticles,
        child: ListView.separated(
          itemBuilder: _buildArticleItem,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 0.5,
              color: Colors.black26,
            );
          },
          itemCount: _articles.length + 2,
          controller: _scrollController,
        ),
      ),
      drawer: MainDrawer(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}