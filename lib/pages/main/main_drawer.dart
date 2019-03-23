import 'package:flutter/material.dart';
import 'package:wan/assets/images.dart';

import 'package:wan/common/App.dart';
import 'package:wan/router/w_router.dart';



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
        onTap: (){ WRouter.gotoLoginPage(context); },
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

  Widget _buildItem(String text, String imagePath, Function onTap) {
    return ListTile(
      title: Text(
        text,
        textAlign: TextAlign.left,
      ),
      leading: Image.asset(imagePath, width: 24, height: 24,),
      onTap: onTap,
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
          _buildItem('我的收藏', ImageAsset.icIceCream, (){ WRouter.gotoMyCollectionsPage(context); }),
          _buildItem('常用网站', ImageAsset.icPear, (){ WRouter.gotoFriendWebsitePage(context); }),
          _buildItem('白板', ImageAsset.icMilk, (){ WRouter.gotoWhiteBoardPage(context); }),
          _buildItem('模板', ImageAsset.icBread, (){ WRouter.gotoTemplatePage(context); }),
          _buildItem('设置', ImageAsset.icHamburg, (){ WRouter.gotoSettingsPage(context); }),
          _buildItem('关于', ImageAsset.icKiwi, (){ WRouter.gotoAboutPage(context); }),
        ],
      ),
    );
  }
}