import 'package:flutter/material.dart';

import '../../common/app.dart';
import '../../event/login_event.dart';

/// 主页面的抽屉组件
class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  void _registerThemeEvent() {
    App.eventBus
      .on<LoginEvent>()
      .listen((LoginEvent event) => _changeUI());
  }

  void _changeUI() {
    setState(() {
      print('Change ui after login.');
      // TODO
    });
  }

  @override
  void initState() {
    super.initState();
    _registerThemeEvent();
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: Is is need to unregister theme event?
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Text('抽屉菜单'),
    );
  }
}