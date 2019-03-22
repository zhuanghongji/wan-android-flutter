import 'dart:convert';

/// 热键
class Hotkey {

  int id;
  int order;
  int visible;
  String link;
  String name;

  Hotkey.fromParams({
    this.id, 
    this.order, 
    this.visible, 
    this.link, 
    this.name
  });

  Hotkey.fromJson(jsonRes) {
    id = jsonRes['id'];
    order = jsonRes['order'];
    visible = jsonRes['visible'];
    link = jsonRes['link'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": $id,"order": $order,"visible": $visible,"link": ${link != null?'${json.encode(link)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}