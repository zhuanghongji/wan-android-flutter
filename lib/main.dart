import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_bus/event_bus.dart';

import 'pages/main/main_page.dart';

import 'api/api_service.dart';
import 'common/app.dart';
import 'common/user.dart';
import 'constant/sp_constant.dart';
import 'config/global_config.dart';
import 'event/config_event.dart';

void main() async {
  bool themeIndex = await getTheme();
  getLoginInfo();
  runApp(MyApp(themeIndex));
} 

Future<bool> getTheme() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool themeIndex = sp.getBool(SpConstant.THEME_INDEX);
  if (themeIndex == null) {
    themeIndex = false;
  }
  GlobalConfig.dark = themeIndex;
  return themeIndex;
}

Future<Null> getLoginInfo() async {
  User.singleton.getUserInfo();
}

class MyApp extends StatefulWidget {
  final bool themeIndex;

  MyApp(this.themeIndex);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _themeData;

  void _registerThemeEvent() {
    App.eventBus
      .on<ThemeChangedEvent>()
      .listen((ThemeChangedEvent event) => this._changeThemeData(event));
  }

  void _changeThemeData(ThemeChangedEvent event) {
    setState(() {
      _themeData = GlobalConfig.getThemeData(event.dark);
    });
  }

  @override
  void initState() {
    super.initState();
    App.eventBus = EventBus();
    _themeData =GlobalConfig.getThemeData(widget.themeIndex);
  }

  @override
  void dispose() {
    super.dispose();
    App.eventBus.destroy();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wan',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: _themeData,
    );
  }
}
