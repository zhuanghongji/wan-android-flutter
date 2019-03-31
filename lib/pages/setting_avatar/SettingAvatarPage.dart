
import 'package:flutter/material.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/base/base_page.dart';
import 'package:wan/manager/sp_manager.dart';
import 'package:wan/router/w_router.dart';

/// 设置头像地址页面
class SettingAvatarPage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _SettingAvatarPageState();
}

class _SettingAvatarPageState extends BasePageState<SettingAvatarPage> {
  /// 头像地址
  String _avatarUrl;
  /// FocusNode
  FocusNode _focusNode = FocusNode();
  /// 输入框控制器
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    showContent();
    // 获取头像
    SpManager.getString(SpConstant.avatarUrl).then((avatarUrl) {
      setState(() {
        _avatarUrl = avatarUrl;
        _textEditingController = TextEditingController(text: avatarUrl);
      });
    }); 
  }

  void _onConfirm() {
    print('_onConfirm, _avatarUrl = $_avatarUrl');
    // Todo: 修改头像成功后发送 Event 到首页，以更新抽屉中的头像
    SpManager.setString(SpConstant.avatarUrl, _avatarUrl); 
    WRouter.maybePop(context);
  }

  Widget _buildPreviewAvatar() {
    double size = 160;
    Widget avatar;
    if (_avatarUrl != null && _avatarUrl.startsWith('http')) {
      print('network image, url = $_avatarUrl');
      avatar = Image.network(_avatarUrl, width: size, height: size);
    } else {
      print('asset image');
      avatar = Container(
        color: Colors.grey[900],
        child: Image.asset(ImageAsset.icAvatar, width: size, height: size),
      );
    }
    return Container(
      height: 200,
      child: Center(
        child: avatar,
      )
    );
  }

  Widget _buildInput() {
    var textStyle =TextStyle(
      fontSize: 16,
    );
    return Container(
      padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
      color: Colors.white,
      child: TextField(
        style: textStyle,
        maxLines: 1,
        autofocus: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '请输入头像地址..',
        ),
        focusNode: _focusNode,
        controller: _textEditingController,
        onSubmitted: (value) {
          print('onSubmitted');
          setState(() {
            _avatarUrl = value;
          });
        },
      )
    );
  }

  Widget _buildInputExample() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Row(
        children: <Widget>[
          Text(
            '比如: https://github.com/zhuanghongji.png',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding:EdgeInsets.fromLTRB(0, 24, 0, 0),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: const Color(0xFF5394FF),
            width: 1
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.grey[800],
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 60,
          ),
          child: Text(
            '确定',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        onPressed: _onConfirm,
      ),
    );
  }

  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text('设置头像地址'),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 32, 0, 32),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildPreviewAvatar(),
          _buildInput(),
          _buildInputExample(),
          _buildConfirmButton(),
        ],
      ),
    );
  }
}