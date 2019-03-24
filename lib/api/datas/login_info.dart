

/// 登录信息
class LoginInfo {

  String email;
  String icon;
  int id;
  String password;
  String token;
  int type;
  String username;
  List<dynamic> chapterTops;
  List<int> collectIds;

  LoginInfo.fromParams({
    this.email, 
    this.icon, 
    this.id, 
    this.password, 
    this.token, 
    this.type, 
    this.username, 
    this.chapterTops, 
    this.collectIds, 
  });

  LoginInfo.fromJson(jsonRes) {
    email = jsonRes['email'];
    icon = jsonRes['icon'];
    id = jsonRes['id'];
    password = jsonRes['password'];
    token = jsonRes['token'];
    type = jsonRes['type'];
    username = jsonRes['username'];
    chapterTops = jsonRes['chapterTops'] == null ? null : [];
    collectIds = jsonRes['collectIds'] == null ? null : [];

    for (var chapterTop in chapterTops == null ? [] : jsonRes['chapterTops']){
      chapterTops.add(chapterTop);
    }

    for (var collectId in collectIds == null ? [] : jsonRes['collectIds']){
      collectIds.add(collectId);
    }
  }

  @override
  String toString() {
    return '{"email": $email,"icon": $icon,"id": $id,"password": $password,"token": $token,"type": $type,"username": $username,"chapterTops": $chapterTops,"collectIds": $collectIds';
  }
}