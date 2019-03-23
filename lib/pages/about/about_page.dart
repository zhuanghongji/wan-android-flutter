
import 'package:flutter/material.dart';
import 'package:wan/base/base_page.dart';

/// 白板页面
/// 
/// 可用来快速编写组件代码并验证，或作其它用途
class AboutPage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _AboutPageState();
}

class _AboutPageState extends BasePageState<AboutPage> {
  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text('关于'),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Text('关于');
  }
}