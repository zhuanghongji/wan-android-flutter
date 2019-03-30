
import 'package:flutter/material.dart';
import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/collection.dart';
import 'package:wan/api/datas/collections.dart';
import 'package:wan/base/base_page.dart';
import 'package:wan/widget/collection_item.dart';
import 'package:wan/widget/loading_item.dart';

/// 我的收藏页面
class MyCollectionsPage extends BasePage {
  @override
  BasePageState<BasePage> getPageState() => _MyCollectionsPageState();
}

class _MyCollectionsPageState extends BasePageState<MyCollectionsPage> {
  /// 页码（收藏）
  int _pageNum = 0;
  /// 收藏列表
  List<Collection> _collections = [];

  LoadingType _loadingType = LoadingType.loading;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    showContent();
    _getCollections();
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _moreCollections();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  _setupLoadingType(LoadingType type) {
    setState(() {
      _loadingType = type;
    });
  }

  /// 获取收藏列表
  Future<void> _getCollections() async {
    _setupLoadingType(LoadingType.loading);
    _pageNum = 0;
    ApiService.getCollections(_pageNum).then((Collections collections) {
      setState(() {
        _collections.clear();
        _collections.addAll(collections.datas);
        var allLoaded = _collections.length >= collections.total;
        _setupLoadingType(allLoaded ? LoadingType.allLoaded : LoadingType.normal);
      });
    });
  }

  /// 获取更多收藏列表
  void _moreCollections() {
    _setupLoadingType(LoadingType.loading);
    _pageNum++;
    ApiService.getCollections(_pageNum).then((Collections collections) {
      setState(() {
        _collections.addAll(collections.datas);
        var allLoaded = _collections.length >= collections.total;
        _setupLoadingType(allLoaded ? LoadingType.allLoaded : LoadingType.normal);
      });
    });
  }

  Widget _buildCollectionItem(BuildContext context, int index) {
    // 文章
    if (index < _collections.length) {
      var collection = _collections[index];
      return CollectionItem(collection, () {
        ApiService.uncollect(collection.id, collection.originId);
        setState(() {
          _collections.removeAt(index);  
        });
      });
    }
    // 加载状态
    return LoadingItem(_loadingType);
  }

  @override
  Widget buildAppBar() {
    return AppBar(
      title: Text('我的收藏'),
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getCollections,
      child: ListView.separated(
        itemBuilder: _buildCollectionItem,
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            height: 0.5,
            color: Colors.black26,
          );
        },
        itemCount: _collections.length + 1,
        controller: _scrollController,
      ),
    );
  }
}