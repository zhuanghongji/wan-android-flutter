
import 'package:flutter/material.dart';
import 'package:wan/api/api_service.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/base/base_page.dart';
import 'package:wan/manager/user_manager.dart';
import 'package:wan/router/w_router.dart';

/// 设置页面
class SettingsPage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _SettingsPageState();
}

class _SettingsPageState extends BasePageState<SettingsPage> {

  @override
  void initState() {
    super.initState();
    showContent();
  }

  void _onLogoutPressed() {
    print('退出登录');
    ApiService.logout().then((dynamic _) {
      UserManager().clearLoginInfo();
      WRouter.pushAndRemoveUntilLoginPage(context);
    });
  }

  Widget _buildItem(String title, String subTitle, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
        color: Colors.white,
        child: Row(
          children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: Text(
                  subTitle,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.right,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 8),
                child: Image.asset(ImageAsset.icArrowRight, width: 24, height: 24),
              ),
            ],
          ),
      ),
    );
  }

  Widget _buildLogoutButton() {
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
            '退出登录',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        onPressed: _onLogoutPressed,
      ),
    );
  }

  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text('设置'),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    var divider =Container(
      height: 24,
    );
    return Container(
      padding: EdgeInsets.fromLTRB(0, 32, 0, 32),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildItem('设置头像地址', '', (){}),
          divider,
          _buildLogoutButton(),
        ],
      ),
    );
  }
}