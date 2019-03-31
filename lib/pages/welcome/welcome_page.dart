
import 'package:flutter/material.dart';
import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/login_info.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/base/base_page.dart';
import 'package:wan/manager/sp_manager.dart';
import 'package:wan/manager/user_manager.dart';
import 'package:wan/router/w_router.dart';

/// 启动页面
class WelcomePage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _WelcomePageState();
}

class _WelcomePageState extends BasePageState<WelcomePage> {
  String _username;
  String _password;

  void tryLogin() {
    if (_username == null || _password == null) {
      print('_username($_username) 或 _password($_password) 为空，跳转到登录页面');
      WRouter.pushReplacementLoginPage(context);
      return;
    }
    ApiService.login(_username, _password).then((LoginInfo info) {
      UserManager().saveLoginInfo(_username, _password, info.email);
      WRouter.pushReplacementMainPage(context);
    }).catchError((e) {
      print('尝试登录异常，跳转到登录页面');
      WRouter.pushReplacementLoginPage(context);
    }); 
  }

  @override
  void initState() {
    super.initState();
    // showContent();
    Future uf = SpManager.getString(SpConstant.username).then((value) {
      _username = value;
    });
    Future pf = SpManager.getString(SpConstant.password).then((value) {
      _password = value;
    });
    Future.wait([uf, pf]).then((dynamic _) {
      tryLogin();
    }).catchError((e) {
      print('获取账号或密码异常，跳转到登录页面');
      WRouter.pushReplacementLoginPage(context);
    });
  }

  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text(''),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.asset(
              ImageAsset.bgWan
            ),
          )
        ],
      ),
    );
  }
}