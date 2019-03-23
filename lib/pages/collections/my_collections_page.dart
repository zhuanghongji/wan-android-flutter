
import 'package:flutter/material.dart';
import 'package:wan/base/base_page.dart';

/// 我的收藏页面
class MyCollectionsPage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _MyCollectionsPageState();
}

class _MyCollectionsPageState extends BasePageState<MyCollectionsPage> {
  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text('我的收藏'),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Text('我的收藏');
  }
}