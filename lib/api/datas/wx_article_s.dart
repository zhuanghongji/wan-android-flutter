import 'package:wan/api/datas/wx_article.dart';

/// 微信文章列表
class WxArticles {

  int curPage;
  int offset;
  int pageCount;
  int size;
  int total;
  bool over;
  List<WxArticle> datas;

  WxArticles.fromParams({
    this.curPage, 
    this.offset, 
    this.pageCount, 
    this.size, 
    this.total, 
    this.over, 
    this.datas
  });

  WxArticles.fromJson(jsonRes) {
    curPage = jsonRes['curPage'];
    offset = jsonRes['offset'];
    pageCount = jsonRes['pageCount'];
    size = jsonRes['size'];
    total = jsonRes['total'];
    over = jsonRes['over'];
    datas = jsonRes['datas'] == null ? null : [];

    for (var datasItem in datas == null ? [] : jsonRes['datas']){
      datas.add(datasItem == null ? null : WxArticle.fromJson(datasItem));
    }
  }

  @override
  String toString() {
    return '{"curPage": $curPage,"offset": $offset,"pageCount": $pageCount,"size": $size,"total": $total,"over": $over,"datas": $datas}';
  }
}