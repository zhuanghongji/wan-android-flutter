
import 'package:flutter/material.dart';
import 'package:wan/base/base_page.dart';

/// 设置页面
class SettingsPage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _SettingsPageState();
}

class _SettingsPageState extends BasePageState<SettingsPage> {

  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text('设置'),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Text('设置');
  }
}