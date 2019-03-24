
import 'package:flutter/material.dart';
import 'package:wan/base/base_page.dart';

/// 模板页面
class RegisterPage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _RegisterPageState();
}

class _RegisterPageState extends BasePageState<RegisterPage> {


  @override
  void initState() {
    super.initState();
    showContent();
  }

  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text('注册'),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Text('注册');
  }
}