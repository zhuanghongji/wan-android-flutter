
import 'package:flutter/material.dart';
import 'package:wan/base/base_page.dart';

/// 登录页面
class LoginPage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage> {

  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text('登录'),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Text('登录');
  }
}