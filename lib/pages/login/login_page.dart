
import 'package:flutter/material.dart';
import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/login_info.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/base/base_page.dart';
import 'package:wan/manager/user_manager.dart';
import 'package:wan/router/w_router.dart';

/// 登录页面
class LoginPage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage> {

  String _username = '';
  String _password = '';

  bool _isObscureText = true;

  void _onToggleObscure() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  void _onLoginPressed() {
    if (_username.isEmpty || _password.isEmpty) {
      return;
    }
    print('开始登录');
    ApiService.login(_username, _password).then((LoginInfo info) {
      UserManager().saveLoginInfo(_username, _password, info.email);
      WRouter.gotoMainPage(context);
    });
  }

  void _onVisitorLogin() {
    String waf = 'wan-android-flutter';
    ApiService.login(waf, waf).then((LoginInfo info) {
      UserManager().saveLoginInfo(waf, waf, info.email);
      WRouter.gotoMainPage(context);
    });
  }

  Widget _buildInput() {
    var bottomLine = Container(
      height: 0.2,
      color: Colors.grey,
    );
    var centerDivider = Container(
      height: 24,
    );
    var textStyle =TextStyle(
      fontSize: 20,
    );
    var passwordSuffixImagePath = _isObscureText ?  ImageAsset.icEyeClose : ImageAsset.icEyeOpen;

    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            maxLines: 1,
            style: textStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '用户名',
            ),
            onChanged: (String input) {
              setState(() {
                _username = input;
              });
            },
          ),
          bottomLine,
          centerDivider,

          TextField(
            maxLines: 1,
            obscureText: _isObscureText,
            style: textStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '密码',
              suffixIcon: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 4,
                  height: 4,
                  child: GestureDetector(
                    child: Image.asset(passwordSuffixImagePath),
                    onTap: _onToggleObscure,
                  )
                )
              )
            ),
            onChanged: (String input) {
              setState(() {
                _password = input;
              });
            },
          ),
          bottomLine,
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      child: FlatButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: const Color(0xFF5394FF),
            width: 1
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 60,
          ),
          child: Text(
            '登录',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        onPressed: _onLoginPressed,
      ),
    );
  }

  Widget _buildVisitorButton() {
    return Container(
      padding: EdgeInsets.all(24),
      child: InkWell(
        onTap: _onVisitorLogin,
        child: Text(
          '游客登录',  
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    showContent();
  }

  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text(''),
      elevation: 0,
      actions: <Widget>[
        FlatButton(
          child: Text(
            '注册',
            style: TextStyle(fontSize: 16),
          ),
          onPressed: (){ WRouter.gotoRegisterPage(context); },
        ),
      ],
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(
              '账号登录',
              style: TextStyle(fontSize: 24),
            )
          ),
        ),
        _buildInput(),
        _buildLoginButton(),
        _buildVisitorButton(),
      ],
    );
  }
}