import 'dart:convert';

/// 收藏的网站
class WebsiteCollection {

  int id;
  int order;
  int userId;
  int visible;
  String desc;
  String icon;
  String link;
  String name;

  WebsiteCollection.fromParams({
    this.id, 
    this.order, 
    this.userId, 
    this.visible, 
    this.desc, 
    this.icon, 
    this.link, 
    this.name
  });
  
  WebsiteCollection.fromJson(jsonRes) {
    id = jsonRes['id'];
    order = jsonRes['order'];
    userId = jsonRes['userId'];
    visible = jsonRes['visible'];
    desc = jsonRes['desc'];
    icon = jsonRes['icon'];
    link = jsonRes['link'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": $id,"order": $order,"userId": $userId,"visible": $visible,"desc": ${desc != null?'${json.encode(desc)}':'null'},"icon": ${icon != null?'${json.encode(icon)}':'null'},"link": ${link != null?'${json.encode(link)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}