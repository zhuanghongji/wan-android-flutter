
import 'package:flutter/material.dart';
import 'package:wan/base/base_page.dart';

/// 模板页面
class TemplatePage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _TemplatePageState();
}

class _TemplatePageState extends BasePageState<TemplatePage> {


  @override
  void initState() {
    super.initState();
    showContent();
  }

  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text('模板'),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Text('模板');
  }
}