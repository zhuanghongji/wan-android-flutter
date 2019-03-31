
import 'package:wan/manager/sp_manager.dart';

// const _TAG = 'UserManager:';

class UserManager {

  String _username;
  String _password;
  String _email;

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

    SpManager.getString(SpConstant.email).then((value) {
      _email = value;
    });
  }

  String getUsername() {
    return _username;
  }

  String getEmail() {
    if (_email == null) {
      return "";
    }
    return _email;
  }

  void saveLoginInfo(String username, String password, String email) {
    _username = username;
    _password = password;
    _password = email;
    SpManager.setString(SpConstant.username, username);
    SpManager.setString(SpConstant.password, password);
    SpManager.setString(SpConstant.email, email);
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
    _email = null;
    SpManager.remove(SpConstant.username);
    SpManager.remove(SpConstant.password);
    SpManager.remove(SpConstant.email);
  }
}