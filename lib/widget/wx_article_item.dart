import 'package:flutter/material.dart';
import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/wx_article.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/router/w_router.dart';
import 'package:wan/style/text_style.dart';
import 'package:wan/utils/time_line.dart';
import 'package:wan/widget/collection.dart';
import 'package:wan/widget/tags.dart';

/// 文章列表项
class WxArticleItem extends StatelessWidget {
  final WxArticle wxArticle;

  WxArticleItem(this.wxArticle);

  /// 收藏状态发生变化
  /// 
  /// - [wxArticle] 对应微信文章
  /// - 如果 [newCollected] 为 `true` 则表示收藏该文章；否则，取消收藏该文章
  void _onCollectedChange(WxArticle wxArticle, bool newCollected) {
    if (newCollected) {
      ApiService.collectOriginId(wxArticle.id);
      return;
    }
    ApiService.uncollectOriginId(wxArticle.id);
  }

  Widget _buildTitle(WxArticle wxArticle) {
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
              wxArticle.author,
              style: TextStyles.author(),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: Text(
              TimelineUtil.format(wxArticle.publishTime),
              style: TextStyles.publishTime(),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTagsAndElse(WxArticle wxArticle) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 12, 16, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // tag 和 superChapterName 都是 "公众号" 两个字，所以不显示先
          // Tags(wxArticle.tags),
          // Container(
          //   padding: EdgeInsets.only(left: 8),
          //   child: Text(wxArticle.superChapterName,
          //     style: TextStyles.superChapterName(),
          //   ),
          // ),
          Expanded(
            child: Text(''),
          ),
          CollectionView(
            initialCollected: wxArticle.collect,
            onChange: (bool newCollected) {
              _onCollectedChange(wxArticle, newCollected);
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
        WRouter.pushWebPage(context, wxArticle.title, wxArticle.link);
      },
      child: Column(
        children: <Widget>[
          _buildTitle(wxArticle),
          Container(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 0),
            alignment: Alignment.topLeft,
            child: Text(
              wxArticle.title,
              maxLines: 2,
              style: TextStyles.title(),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _buildTagsAndElse(wxArticle),
        ],
      ),
    );
  }
}