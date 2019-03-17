import 'dart:convert' show json;

/// 网站
class Website {

  int id;
  int order;
  int visible;
  String icon;
  String link;
  String name;

  Website.fromParams({
    this.id, 
    this.order, 
    this.visible, 
    this.icon, 
    this.link, 
    this.name
  });

  Website.fromJson(jsonRes) {
    id = jsonRes['id'];
    order = jsonRes['order'];
    visible = jsonRes['visible'];
    icon = jsonRes['icon'];
    link = jsonRes['link'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": $id,"order": $order,"visible": $visible,"icon": ${icon != null?'${json.encode(icon)}':'null'},"link": ${link != null?'${json.encode(link)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}