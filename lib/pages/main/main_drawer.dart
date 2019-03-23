import 'package:flutter/material.dart';
import 'package:wan/assets/images.dart';

import 'package:wan/common/App.dart';
import 'package:wan/event/login_event.dart';



/// 主页面的抽屉组件
class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  void _registerThemeEvent() {
    // App.eventBus
    //   .on<LoginEvent>()
    //   .listen((LoginEvent event) => _changeUI());
  }

  void _changeUI() {
    setState(() {
      print('Change ui after login.');
      // Todo
    });
  }

  Widget _buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: InkWell(
        child: Text(
          '点击登录',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onTap: (){ 
          print('gotoLoginPage'); 
        },
      ),
      accountEmail: null,
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage(ImageAsset.icAvatar),
        backgroundColor: Colors.transparent,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        // image: DecorationImage(
        //   image: AssetImage(ImageAsset.bgDrawer1),
        //   fit: BoxFit.cover,
        // )
      ),
    );
  }

  Widget _buildMyCollections() {
    return ListTile(
      title: Text(
        '我的收藏',
        textAlign: TextAlign.left,
      ),
      leading: Image.asset(ImageAsset.icIceCream, width: 24, height: 24,),
      onTap: () { print('我的收藏');},
    );
  }

  Widget _buildFriendWebsite() {
    return ListTile(
      title: Text(
        '常用网站',
        textAlign: TextAlign.left,
      ),
      leading: Image.asset(ImageAsset.icPear, width: 24, height: 24,),
      onTap: () { print('常用网站');},
    );
  }

  Widget _buildSetting() {
    return ListTile(
      title: Text(
        '设置',
        textAlign: TextAlign.left,
      ),
      leading: Image.asset(ImageAsset.icHamburg, width: 24, height: 24,),
      onTap: () { print('设置');},
    );
  }

  Widget _buildAbout() {
    return ListTile(
      title: Text(
        '关于',
        textAlign: TextAlign.left,
      ),
      leading: Image.asset(ImageAsset.icKiwi, width: 24, height: 24,),
      onTap: () { print('关于');},
    );
  }

  @override
  void initState() {
    super.initState();
    _registerThemeEvent();
  }

  @override
  void dispose() {
    super.dispose();
    App.eventBus.destroy();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          _buildDrawerHeader(),
          _buildMyCollections(),
          _buildFriendWebsite(),
          _buildSetting(),
          _buildAbout(),
        ],
      ),
    );
  }
}