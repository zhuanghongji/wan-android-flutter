import 'package:flutter/material.dart';
import 'package:wan/api/datas/collection.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/router/w_router.dart';
import 'package:wan/style/text_style.dart';
import 'package:wan/utils/time_line.dart';
import 'package:wan/widget/collection.dart';

/// 收藏列表项
class CollectionItem extends StatelessWidget {
  final Collection collection;
  final Function onUncollect;

  CollectionItem(this.collection, this.onUncollect);

  Widget _buildTitle(Collection collection) {
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
              collection.author,
              style: TextStyles.author(),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: Text(
              TimelineUtil.format(collection.publishTime),
              style: TextStyles.publishTime(),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTagsAndElse(Collection collection) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 12, 16, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8),
            child: Text(collection.chapterName,
              style: TextStyles.superChapterName(),
            ),
          ),
          Expanded(
            child: Text(''),
          ),
          CollectionView(
            initialCollected: true,
            isLocked: true,
            onChange: (bool _) {
              onUncollect();
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
        WRouter.pushWebPage(context, collection.title, collection.link);
      },
      child: Column(
        children: <Widget>[
          _buildTitle(collection),
          Container(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 0),
            alignment: Alignment.topLeft,
            child: Text(
              collection.title,
              maxLines: 2,
              style: TextStyles.title(),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _buildTagsAndElse(collection),
        ],
      ),
    );
  }
}