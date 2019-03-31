
import 'package:flutter/material.dart';
import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/login_info.dart';
import 'package:wan/base/base_page.dart';
import 'package:wan/manager/user_manager.dart';
import 'package:wan/router/w_router.dart';

/// 模板页面
class RegisterPage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _RegisterPageState();
}

class _RegisterPageState extends BasePageState<RegisterPage> {
  String _username = '';
  String _password = '';
  String _repassword = '';

   void _onRegisterPressed() {
     if (_username.isEmpty) {
       print('请输入用户名');
       return;
     }
     if (_password.isEmpty) {
       print('请输入密码');
       return;
     }
     if (_repassword.isEmpty) {
       print('请输入确认密码');
       return;
     }
    ApiService.register(_username, _password, _repassword).then((LoginInfo info) {
      // 注意，可能该账号已被注册，或账号密码长度为大于或等于6位
      UserManager().saveLoginInfo(_username, _password, info.email);
      WRouter.pushAndRemoveUntilMainPage(context);
    });
  }

  Widget _buildInput(String hintText, Function(String) onTextChange, { obscureTex = false }) {
    return TextField(
      maxLines: 1,
      obscureText: obscureTex,
      style: TextStyle(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
      ),
      onChanged: onTextChange,
    );
  }

  Widget _buildRegisterButton() {
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
            '注册',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        onPressed: _onRegisterPressed,
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
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    var bottomLine = Container(
      height: 0.2,
      color: Colors.grey,
    );
    var centerDivider = Container(
      height: 24,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(
              '账号注册',
              style: TextStyle(fontSize: 24),
            )
          ),
        ),
        Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              _buildInput('用户名', (String input){ setState(() {
                _username = input;
              }); }),
              bottomLine,
              centerDivider,
              _buildInput('密码', (String input){ setState(() {
                _password = input;
              }); }, obscureTex: true),
              bottomLine,
              centerDivider,
              _buildInput('确认密码', (String input){ setState(() {
                _repassword = input;
              }); }, obscureTex: true),
              bottomLine,
            ],
          ),
        ),
        _buildRegisterButton(),
      ],
    );
  }
}