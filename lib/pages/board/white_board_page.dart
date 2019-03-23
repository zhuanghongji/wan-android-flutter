
import 'package:flutter/material.dart';
import 'package:wan/base/base_page.dart';

/// 白板页面
/// 
/// 可用来快速编写组件代码并验证，或作其它用途
class WhiteBoardPage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _WhiteBoardPageState();
}

class _WhiteBoardPageState extends BasePageState<WhiteBoardPage> {
  _onApiTest() {
    print('_onApiTest');
  }

  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text('白板'),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          child: Text('测试接口调用'),
          onPressed: _onApiTest,
        )
      ],
    );
  }
}