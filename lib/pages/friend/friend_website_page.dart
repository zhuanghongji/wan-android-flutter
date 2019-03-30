
import 'package:flutter/material.dart';
import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/Friend.dart';
import 'package:wan/base/base_page.dart';
import 'package:wan/router/w_router.dart';

/// 常用网站页面
class FriendWebsitePage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _FriendWebsitePageState();
}

class _FriendWebsitePageState extends BasePageState<FriendWebsitePage> {
  List<Friend> _friends = [];

  @override
  void initState() {
    super.initState();
    _getFriends();
  }

  void _getFriends() {
    ApiService.getFridends().then((List<Friend> friends) {
      setState(() {
        _friends.clear();
        _friends.addAll(friends);
        showContent();
      });
    });
  }

  void _onFriendItemPressed(Friend friend) {
    print(friend);
    WRouter.gotoWebPage(context, friend.name, friend.link);
  }

  Widget _buildFriends(List<Friend> friends) {
    Widget result;
    List<Widget> chips = [];
    for (var friend in friends) {
      chips.add(RawChip(
        onPressed: () { _onFriendItemPressed(friend); },
        label: Text(friend.name),
      ));
    }
    result = Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      alignment: WrapAlignment.start,
      children: chips,
    );
    return result;
  }

  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text('常用网站'),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: _buildFriends(_friends),
    );
  }
}