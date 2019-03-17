import 'dart:convert' show json;

/// 标签
class Tag {

  String name;
  String url;

  Tag.fromParams({this.name, this.url});

  Tag.fromJson(jsonRes) {
    name = jsonRes['name'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"name": ${name != null?'${json.encode(name)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'}}';
  }
}