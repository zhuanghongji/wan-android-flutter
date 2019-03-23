
import 'package:flutter/material.dart';
import 'package:wan/base/base_page.dart';

/// 常用网站页面
class FriendWebsitePage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _FriendWebsitePageState();
}

class _FriendWebsitePageState extends BasePageState<FriendWebsitePage> {

  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text('常用网站'),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Text('常用网站');
  }
}