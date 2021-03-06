import 'package:flutter/material.dart';

/// 主页底部的 Tab 导航栏
class MainBottomNavigationBar extends StatefulWidget {

  final int index;
  final ValueChanged<int> onChanged;

  MainBottomNavigationBar({ 
    Key key, 
    this.index = 0, 
    @required this.onChanged 
  }): super(key: key);

  @override
  _MainBottomNavigationBarState createState() => _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> with AutomaticKeepAliveClientMixin {

  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    widget.onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTap,
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('首页')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.next_week),
          title: Text('待办')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.streetview),
          title: Text('体系')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.navigation),
          title: Text('导航')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          title: Text('发现')
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}