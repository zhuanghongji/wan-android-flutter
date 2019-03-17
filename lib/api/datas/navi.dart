import 'dart:convert' show json;

import 'navi_article.dart';

/// 导航 
class Navi {

  int cid;
  String name;
  List<NaviArticle> articles;

  Navi.fromParams({
    this.cid, 
    this.name, 
    this.articles
  });

  Navi.fromJson(jsonRes) {
    cid = jsonRes['cid'];
    name = jsonRes['name'];
    articles = jsonRes['articles'] == null ? null : [];

    for (var articlesItem in articles == null ? [] : jsonRes['articles']){
      articles.add(articlesItem == null ? null : NaviArticle.fromJson(articlesItem));
    }
  }

  @override
  String toString() {
    return '{"cid": $cid,"name": ${name != null?'${json.encode(name)}':'null'},"articles": $articles}';
  }
}