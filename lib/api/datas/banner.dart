import 'dart:convert' show json;

class Banner {

  int id;
  int isVisible;
  int order;
  int type;
  String desc;
  String imagePath;
  String title;
  String url;

  Banner.fromParams({
    this.id, 
    this.isVisible, 
    this.order, 
    this.type, 
    this.desc, 
    this.imagePath, 
    this.title, 
    this.url
  });

  Banner.fromJson(jsonRes) {
    id = jsonRes['id'];
    isVisible = jsonRes['isVisible'];
    order = jsonRes['order'];
    type = jsonRes['type'];
    desc = jsonRes['desc'];
    imagePath = jsonRes['imagePath'];
    title = jsonRes['title'];
    url = jsonRes['url'];
  }
}