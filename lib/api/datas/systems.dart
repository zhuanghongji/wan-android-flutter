// import 'dart:convert' show json;

import 'system.dart';

class Systems {

  int curPage;
  int offset;
  int pageCount;
  int size;
  int total;
  bool over;
  List<System> datas;

  Systems.fromParams({
    this.curPage, 
    this.offset, 
    this.pageCount, 
    this.size, 
    this.total, 
    this.over, 
    this.datas
  });

  Systems.fromJson(jsonRes) {
    curPage = jsonRes['curPage'];
    offset = jsonRes['offset'];
    pageCount = jsonRes['pageCount'];
    size = jsonRes['size'];
    total = jsonRes['total'];
    over = jsonRes['over'];
    datas = jsonRes['datas'] == null ? null : [];

    for (var datasItem in datas == null ? [] : jsonRes['datas']){
      datas.add(datasItem == null ? null : System.fromJson(datasItem));
    }
  }

  @override
  String toString() {
    return '{"curPage": $curPage,"offset": $offset,"pageCount": $pageCount,"size": $size,"total": $total,"over": $over,"datas": $datas}';
  }
}