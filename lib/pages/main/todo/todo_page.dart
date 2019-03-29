import 'package:flutter/material.dart';
import 'package:wan/api/api_constant.dart';
import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/todo.dart';
import 'package:wan/api/datas/todos.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/manager/user_manager.dart';


/// 待办事项页面
class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Todo> _allUnfinishTodos = [];
  List<Todo> _allFinishedTodos = [];
  ScrollController _scrollController = ScrollController();

  int _statusFilter = TodoStatus.todo;

  /// 页码（待办事项）
  int _pageNum = 1;

  /// 获取文章
  Future<void> _getTodos(int _statusFilter) async {
    _pageNum = 1;
    ApiService.getTodos(_pageNum, status: _statusFilter).then((Todos todos){
      setState(() {
        if (_statusFilter == TodoStatus.todo) {
          _allUnfinishTodos.clear();
          _allUnfinishTodos.addAll(todos.datas);
        } else {
          _allFinishedTodos.clear();
          _allFinishedTodos.addAll(todos.datas);
        }
      });
    });
  }

  /// 获取更多文章 
  void _getMoreTodos(int _statusFilter) {
    _pageNum++;
    ApiService.getTodos(_pageNum, status: _statusFilter).then((Todos todos){
      setState(() {
        if (_statusFilter == TodoStatus.todo) {
          _allUnfinishTodos.addAll(todos.datas);
        } else {
          _allFinishedTodos.addAll(todos.datas);
        } 
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getTodos(_statusFilter);
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _getMoreTodos(_statusFilter);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _onTodoItemStatusChanged(bool isChecked) {

  }


  Widget _buildTodoItem(BuildContext context, int index, List<Todo> showTodos) {
    if (index == 0) {
      return _buildTopBar();
    }
    if (index < showTodos.length + 1) {
      var todo = showTodos[index - 1];
      return CheckboxListTile(
        secondary: const Icon(Icons.work),
        title: Text(todo.title),
        subtitle: Text(todo.content),
        value: todo.isDone(),
        activeColor: Colors.grey,
        onChanged: _onTodoItemStatusChanged,
      );
    }

    // 加载更多
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  Widget _buildTopBar() {
    var items = <DropdownMenuItem<int>>[];
    items.add(DropdownMenuItem<int>(value: TodoStatus.done, child: Text('完成')));
    items.add(DropdownMenuItem<int>(value: TodoStatus.todo, child: Text('未完成')));

    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: <Widget>[
          Chip(label: Text('只看这一个')),
          Chip(label: Text('学习')),
          Chip(label: Text('工作')),
          Chip(label: Text('生活')),
          Expanded(flex: 1, child: Text('')),
          DropdownButton<int>(
            value: _statusFilter,
            items: items, 
            onChanged: (value) {
              setState(() {
                _statusFilter = value;
                _getTodos(_statusFilter);
              });
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Todo> _showTodos = [];
    if (_statusFilter == TodoStatus.todo) {
      _showTodos.addAll(_allUnfinishTodos);
    } else {
      _showTodos.addAll(_allFinishedTodos);
    }
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () { _getTodos(_statusFilter); },
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _buildTodoItem(context, index, _showTodos);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 0.5,
              color: Colors.black26,
            );
          },
          itemCount: _showTodos.length + 2,
          controller: _scrollController,
        ),
      ),
    );
  }
}