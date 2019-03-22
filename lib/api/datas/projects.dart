import 'package:wan/api/datas/project.dart';

/// 项目列表
class Projects {

  int curPage;
  int offset;
  int pageCount;
  int size;
  int total;
  bool over;
  List<Project> datas;

  Projects.fromParams({
    this.curPage, 
    this.offset, 
    this.pageCount, 
    this.size, 
    this.total, 
    this.over, 
    this.datas
  });

  Projects.fromJson(jsonRes) {
    curPage = jsonRes['curPage'];
    offset = jsonRes['offset'];
    pageCount = jsonRes['pageCount'];
    size = jsonRes['size'];
    total = jsonRes['total'];
    over = jsonRes['over'];
    datas = jsonRes['datas'] == null ? null : [];

    for (var datasItem in datas == null ? [] : jsonRes['datas']){
      datas.add(datasItem == null ? null : Project.fromJson(datasItem));
    }
  }

  @override
  String toString() {
    return '{"curPage": $curPage,"offset": $offset,"pageCount": $pageCount,"size": $size,"total": $total,"over": $over,"datas": $datas}';
  }
}