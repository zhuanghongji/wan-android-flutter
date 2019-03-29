
import 'package:wan/api/api_constant.dart';

class Todo {

  dynamic completeDate;
  String completeDateStr;
  String content;
  int date;
  String dateStr;
  int id;
  int priority;
  int status;
  String title;
  int type;
  int userId;

  Todo.fromParams({
    this.completeDate,
    this.completeDateStr,
    this.content,
    this.date,
    this.dateStr,
    this.id,
    this.priority,
    this.status,
    this.title,
    this.type,
    this.userId,
  });

  Todo.fromJson(jsonRes) {
    completeDate = jsonRes['completeDate'];
    completeDateStr = jsonRes['completeDateStr'];
    content = jsonRes['content'];
    date = jsonRes['date'];
    dateStr = jsonRes['dateStr'];
    id = jsonRes['id'];
    priority = jsonRes['priority'];
    status = jsonRes['status'];
    title = jsonRes['title'];
    type = jsonRes['type'];
    userId = jsonRes['userId'];
  }

  @override
  String toString() {
    return '{"completeDate": $completeDate,"completeDateStr": $completeDateStr,"content": $content,"date": $date,"dateStr": $dateStr,"id": $id,"priority": $priority,"status": $status,"title": $title,"type": $type,"userId": $userId}';
  }

  /// Return `true` if this todo item is done, else return `false`.
  bool isDone() {
    return TodoStatus.done == status;
  }
}