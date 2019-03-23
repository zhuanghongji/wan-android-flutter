import 'package:flutter/material.dart';
import 'package:wan/base/base_page.dart';

/// 搜索页面


/// 搜索页面
class SearchPage extends BasePage {
  @override
  BasePageState getPageState() => _SearchPageState();
}

class _SearchPageState extends BasePageState<SearchPage> {
  
  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text('搜索'),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Text('搜索内容');
  }
}