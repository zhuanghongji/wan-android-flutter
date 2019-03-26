
import 'package:dio/dio.dart';
import 'package:wan/manager/sp_manager.dart';

const _TAG = 'UserManager:';

class UserManager {

  String _username;
  String _password;
  List<String> _cookies;

  static final UserManager _singleton = UserManager._internal();

  factory UserManager() => _singleton;

  UserManager._internal() {
    init();
  }

  void init() {
    SpManager.getString(SpConstant.username).then((value) {
      _username = value;
    });

    SpManager.getString(SpConstant.password).then((value) {
      _password = value;
    });

    SpManager.getStringList(SpConstant.cookies).then((value) {
      _cookies = value;
    });
  }

  /// 是否已登录
  /// 
  /// Return [true] express is login, else is not login.
  bool isLogin() {
    bool isUsernameValid = _username != null && _username.length >= 6;
    bool isPasswordValid = _password != null && _password.length >= 6;
    return isUsernameValid && isPasswordValid;
  }

  /// 清理登录信息
  void clearLoginInfo() {
    _username = null;
    _password = null;
    _cookies = null;
    SpManager.remove(SpConstant.username);
    SpManager.remove(SpConstant.password);
    SpManager.remove(SpConstant.cookies);
  }

  void saveCookies(Response response) {
    if (_cookies == null) {
      _cookies = List<String>();
    } else {
      _cookies.clear();
    }
    response.headers.forEach((String name, List<String> values) {
      if (name == "set-cookie") {
        _cookies.addAll(values);
      }
    });
    print('$_TAG _cookies = $_cookies');
    SpManager.setStringList(SpConstant.cookies, _cookies);
  }

  List<String> getCookies() {
    if (_cookies == null) {
      return List<String>();
    }
    return _cookies;
  }
}