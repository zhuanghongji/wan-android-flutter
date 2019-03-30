import 'package:flutter/material.dart';
import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/article.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/router/w_router.dart';
import 'package:wan/style/text_style.dart';
import 'package:wan/utils/time_line.dart';
import 'package:wan/widget/collection.dart';
import 'package:wan/widget/tags.dart';

/// 文章列表项
class ArticleItem extends StatelessWidget {
  final Article article;

  ArticleItem(this.article);

  /// 收藏状态发生变化
  /// 
  /// - [article] 对应文章
  /// - 如果 [newCollected] 为 `true` 则表示收藏该文章；否则，取消收藏该文章
  void _onCollectedChange(Article article, bool newCollected) {
    if (newCollected) {
      ApiService.collectOriginId(article.id);
      return;
    }
    ApiService.uncollectOriginId(article.id);
  }

  Widget _buildTitle(Article article) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: <Widget>[
          Image.asset(
            ImageAsset.icMan,
            width: 18,
            height: 18,
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              article.author,
              style: TextStyles.author(),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: Text(
              TimelineUtil.format(article.publishTime),
              style: TextStyles.publishTime(),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTagsAndElse(Article article) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 12, 16, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Tags(article.tags),
          Container(
            padding: EdgeInsets.only(left: 8),
            child: Text(article.superChapterName,
              style: TextStyles.superChapterName(),
            ),
          ),
          Expanded(
            child: Text(''),
          ),
          CollectionView(
            initialCollected: article.collect,
            onChange: (bool newCollected) {
              _onCollectedChange(article, newCollected);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        WRouter.gotoWebPage(context, article.title, article.link);
      },
      child: Column(
        children: <Widget>[
          _buildTitle(article),
          Container(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 0),
            alignment: Alignment.topLeft,
            child: Text(
              article.title,
              maxLines: 2,
              style: TextStyles.title(),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _buildTagsAndElse(article),
        ],
      ),
    );
  }
}