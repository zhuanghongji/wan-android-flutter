
import 'package:wan/manager/sp_manager.dart';

// const _TAG = 'UserManager:';

class UserManager {

  String _username;
  String _password;

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
  }

  void saveLoginInfo(String username, String password) {
    _username = username;
    _password = password;
    SpManager.setString(SpConstant.username, username);
    SpManager.setString(SpConstant.password, password);
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
    SpManager.remove(SpConstant.username);
    SpManager.remove(SpConstant.password);
  }
}