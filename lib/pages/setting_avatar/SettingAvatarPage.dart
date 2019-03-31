
import 'package:flutter/material.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/base/base_page.dart';

/// 设置头像地址页面
class SettingAvatarPage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _SettingAvatarPageState();
}

class _SettingAvatarPageState extends BasePageState<SettingAvatarPage> {
  String _avatarUrl;
  /// FocusNode
  FocusNode _focusNode = FocusNode();
  /// 输入框控制器
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    showContent();
  }

  void _onConfirm() {
    print('_onConfirm, TBD');
  }

  Widget _buildPreviewAvatar() {
    double size = 160;
    Widget avatar;
    if (_avatarUrl == null 
        || !_avatarUrl.startsWith('http://')
        || !_avatarUrl.startsWith('https://')
    ) {
      avatar = Container(
        color: Colors.grey[900],
        child: Image.asset(ImageAsset.icAvatar, width: size, height: size),
      );
    } else {
      avatar = Image.asset(_avatarUrl, width: size, height: size);
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
      child: Text(
        '比如: https://github.com/zhuanghongji.png',
        style: TextStyle(
          color: Colors.grey[500],
        )
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