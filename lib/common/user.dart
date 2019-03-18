import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/datas/user_info.dart';
import '../constant/SpConstant.dart';

class User {

  static final singleton = User._internal();

  factory User() {
    return singleton;
  }

  User._internal();

  String username;
  List<String> cookies;

  /// 保存用户信息
  void saveUserInfo(UserInfo userInfo, Response response) {
    this.cookies = response.headers["set-cookie"];
    username = userInfo.username;
    saveInfo(); 
  }

  /// 获取用户信息
  Future<Null> getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String username = sp.getString(SpConstant.USER_NAME);
    if (username != null) {
      this.username = username;
    }
    List<String> cs = sp.getStringList(SpConstant.COOKIES);
    if (cs != null) {
      this.cookies = cs;
    }
  }

  
  saveInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList(SpConstant.COOKIES, this.cookies);
    sp.setString(SpConstant.USER_NAME, this.username);
  }

  void clearUserInfo() {
    this.username = null;
    this.cookies = null;
  }

  clearInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList(SpConstant.COOKIES, null);
    sp.setString(SpConstant.USER_NAME, null);
  }
}