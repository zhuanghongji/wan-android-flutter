
import 'package:wan/api/datas/todo.dart';

class Todos {

  int curPage;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;
  List<Todo> datas;

  Todos.fromParams({
    this.curPage, 
    this.offset,
    this.over,  
    this.pageCount, 
    this.size, 
    this.total, 
    this.datas
  });

  Todos.fromJson(jsonRes) {
    curPage = jsonRes['curPage'];
    offset = jsonRes['offset'];
    over = jsonRes['over'];
    pageCount = jsonRes['pageCount'];
    size = jsonRes['size'];
    total = jsonRes['total'];
    datas = jsonRes['datas'] == null ? null : [];

    for (var datasItem in datas == null ? [] : jsonRes['datas']){
      datas.add(datasItem == null ? null : Todo.fromJson(datasItem));
    }
  }

  @override
  String toString() {
    return '{"curPage": $curPage,"offset": $offset,"over": $over,"pageCount": $pageCount,"size": $size,"total": $total,"datas": $datas}';
  }
}
