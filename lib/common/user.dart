import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wan/api/datas/user_info.dart';
import 'package:wan/constant/sp_constant.dart';



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

    String username = sp.getString(SpConstant.userName);
    if (username != null) {
      this.username = username;
    }
    List<String> cs = sp.getStringList(SpConstant.cookies);
    if (cs != null) {
      this.cookies = cs;
    }
  }

  
  saveInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList(SpConstant.cookies, this.cookies);
    sp.setString(SpConstant.userName, this.username);
  }

  void clearUserInfo() {
    this.username = null;
    this.cookies = null;
  }

  clearInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList(SpConstant.cookies, null);
    sp.setString(SpConstant.userName, null);
  }
}