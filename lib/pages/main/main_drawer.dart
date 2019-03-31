import 'package:flutter/material.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/manager/user_manager.dart';
import 'package:wan/router/w_router.dart';


/// 主页面的抽屉组件
class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Widget _buildDrawerAccountName() {
    var isLogin = UserManager().isLogin();
    return InkWell(
      child: Text(
        isLogin ? UserManager().getUsername() : '点击登录',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      onTap: isLogin ? (){ WRouter.pushLoginPage(context); } : null,
    );
  }

  Widget _buildDrawerAccountEmail() {
    var email = UserManager().getEmail();
    if (email == null || email.isEmpty) {
      return null;
    }
    return Text(email);
  }

  Widget _buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: _buildDrawerAccountName(),
      accountEmail: _buildDrawerAccountEmail(),
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
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildDrawerHeader(),
          _buildItem('我的收藏', ImageAsset.icIceCream, (){ WRouter.pushMyCollectionsPage(context); }),
          _buildItem('常用网站', ImageAsset.icPear, (){ WRouter.pushFriendWebsitePage(context); }),
          _buildItem('白板', ImageAsset.icMilk, (){ WRouter.pushWhiteBoardPage(context); }),
          _buildItem('模板', ImageAsset.icBread, (){ WRouter.pushTemplatePage(context); }),
          _buildItem('设置', ImageAsset.icHamburg, (){ WRouter.pushSettingsPage(context); }),
          _buildItem('关于', ImageAsset.icKiwi, (){ WRouter.pushAboutPage(context); }),
        ],
      ),
    );
  }
}