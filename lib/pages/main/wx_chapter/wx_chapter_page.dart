import 'package:flutter/material.dart';

import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/wx_chapter.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/router/w_router.dart';

/// 微信公众号页面
class WxChapterPage extends StatefulWidget {
  @override
  _WxChapterPageState createState() => _WxChapterPageState();
}

class _WxChapterPageState extends State<WxChapterPage> {
  List<WxChapter> _wxChapters = [];

  /// 获取公众号列表
  void _getWxChapters() {
    ApiService.getWxChapters().then((List<WxChapter> wxChapters) {
      setState(() {
        _wxChapters.clear();
        _wxChapters.addAll(wxChapters);
      });
    });
  }

  void _onWxChapterItemPressed(WxChapter chapter) {
    print(chapter);
    WRouter.gotoWxChapterArticlesPage(context, chapter.name, chapter.id);
  }

  List<Widget> _buildWxChapterItems(List<WxChapter> wxChapters) {
    List<Widget> chips = [];
    for (var chapter in wxChapters) {
      chips.add(RawChip(
        onPressed: () { _onWxChapterItemPressed(chapter); },
        label: Text(
          chapter.name,
          style: TextStyle(fontSize: 18),
        ),
        avatar: Image.asset(ImageAsset.icMan),
      ));
    }
    return chips;
  }

  @override
  void initState() {
    super.initState();
    _getWxChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Center(
            child: Column(
              children: _buildWxChapterItems(_wxChapters),
            ),
          ),
        ),
      ),
    );
  }
}