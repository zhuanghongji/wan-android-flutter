import 'package:flutter/material.dart';

import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/wx_article.dart';
import 'package:wan/api/datas/wx_article_s.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/base/base_page.dart';
import 'package:wan/router/w_router.dart';
import 'package:wan/utils/time_line.dart';
import 'package:wan/widget/article_item.dart';
import 'package:wan/widget/loading_item.dart';
import 'package:wan/widget/wx_article_item.dart';


/// 微信公众号对应的文章列表页面
class WxChapterArticlesPage extends BasePage {
  final String chapterName;
  final int chapterId;

  WxChapterArticlesPage({ this.chapterName, this.chapterId });

  @override
  BasePageState<BasePage> getPageState() => _WxChapterArticlesPageState();
}

class _WxChapterArticlesPageState extends BasePageState<WxChapterArticlesPage> {
  /// 页码（文章）
  int _pageNum = 0;
  /// 文章列表
  List<WxArticle> _wxArticles = [];

  LoadingType _loadingType = LoadingType.loading;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    showContent();
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

  _setupLoadingType(LoadingType type) {
    setState(() {
      _loadingType = type;
    });
  }

  /// 获取微信公众号对应的文章列表
  Future<void> _getWxArticles() async {
    _setupLoadingType(LoadingType.loading);
    _pageNum = 0;
    ApiService.getWxArticles(widget.chapterId, _pageNum).then((WxArticles wxArticles) {
      setState(() {
        _wxArticles.clear();
        _wxArticles.addAll(wxArticles.datas);
      });
    });
  }

  /// 获取更多微信公众号对应的文章列表
  void _moreWxArticles() {
    _setupLoadingType(LoadingType.loading);
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
      return WxArticleItem(article);
    }
    // 加载状态
    return LoadingItem(_loadingType);
  }

  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text(widget.chapterName),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return RefreshIndicator(
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
    );
  }
}