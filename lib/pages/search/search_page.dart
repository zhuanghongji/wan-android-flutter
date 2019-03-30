import 'package:flutter/material.dart';
import 'package:wan/api/api_service.dart';
import 'package:wan/api/datas/article.dart';
import 'package:wan/api/datas/articles.dart';
import 'package:wan/api/datas/hotkey.dart';
import 'package:wan/assets/images.dart';
import 'package:wan/base/base_page.dart';
import 'package:wan/router/w_router.dart';
import 'package:wan/utils/time_line.dart';
import 'package:wan/widget/loading_item.dart';


/// 搜索页面
class SearchPage extends BasePage {
  /// 默认搜索关键词
  final String defaultSearchKey;

  SearchPage([ this.defaultSearchKey ]);

  @override
  BasePageState getPageState() => _SearchPageState();
}

class _SearchPageState extends BasePageState<SearchPage> {
  /// 热搜关键词列表
  List<Hotkey> _hotkeys = [];

  /// 当前搜索文章的页码
  int _pageNum = 0;
  /// 当前搜索的文章列表
  List<Article> _articles = [];
  /// 搜索文章列表滚动控制器
  ScrollController _scrollController = ScrollController();

  /// 当前输入框的字符串
  String _searchKey = '';
  /// FocusNode
  FocusNode _focusNode = FocusNode();
  /// 文章列表的查询状态
  LoadingType _loadingType = LoadingType.loading;
  /// 搜索输入框控制器
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    showContent();
    _textEditingController = TextEditingController(
      text: widget.defaultSearchKey,
    );

    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _moreArticles();
      }
    });

    ApiService.getHotkeys().then((List<Hotkey> hotkeys) {
      setState(() {
        _hotkeys.clear();
        _hotkeys.addAll(hotkeys);
      });
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

  void _queryArticles(String input) {
    _setupLoadingType(LoadingType.loading);
    _pageNum = 0;
    ApiService.queryArticles(_pageNum, input).then((Articles articles) {
      setState(() {
        _articles.clear();
        _articles.addAll(articles.datas);
        var allLoaded = _articles.length >= articles.total;
        _setupLoadingType(allLoaded ? LoadingType.allLoaded : LoadingType.normal);
      });
    });
  }

  void _moreArticles() {
    if (_loadingType == LoadingType.loading) {
      print('正在加载');
      return;
    }
    _setupLoadingType(LoadingType.loading);
    _pageNum++;
    ApiService.queryArticles(_pageNum, _searchKey).then((Articles articles) {
      setState(() {
        _articles.clear();
        _articles.addAll(articles.datas);
        var allLoaded = _articles.length >= articles.total;
        _setupLoadingType(allLoaded ? LoadingType.allLoaded : LoadingType.normal);
      });
    });
  }

  void _onSearchFieldChange(String input) {
    print(input);
    if (input.isEmpty) {
      // 置为空以显示热搜关键词页面
      setState(() {
        _searchKey = '';
      });
    }
  }

  void _onSearchFieldSubmitted(String input) {
    print(input);
    setState(() {
      _searchKey = input;
    });
    _queryArticles(input);
  }

  Widget _buildHotkeysCaontainer() {
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: Text(
              '大家都在搜',
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          _buildHotkeysWrap(),
        ],
      ),
    );
  }

  Widget _buildHotkeysWrap() {
    List<Widget> chips = [];
    for (var hotkey in _hotkeys) {
      chips.add(RawChip(
        label: Text(hotkey.name),
        onPressed: () {
          setState(() {
            _searchKey = hotkey.name;
            _textEditingController = TextEditingController(text: hotkey.name);
          });
        },
      ));
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.start,
      children: chips,
    );
  }

  Widget _buildSearchResult() {
    return ListView.separated(
      itemBuilder: _buildSearchResultItem,
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 0.5,
          color: Colors.black26,
        );
      },
      itemCount: _articles.length + 1,
      controller: _scrollController,
    );
  }

  Widget _buildSearchResultItem(BuildContext context, int index) {
    // 文章
    if (index < _articles.length) {
      var article =_articles[index];
      return InkWell(
        onTap: () {
          WRouter.gotoWebPage(context, article.title, article.link);
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    ImageAsset.icMan,
                    width: 16,
                    height: 16,
                  ),
                  Text('  '),
                  Text(
                    article.author,
                    style:TextStyle(fontSize: 14),
                    textAlign: TextAlign.start,
                  ),
                  Expanded(
                    child: Text(
                      TimelineUtil.format(article.publishTime),
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                        article.title,
                        maxLines: 2,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: <Widget>[
                  Text(article.superChapterName,
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    // 加载更多
    return LoadingItem(_loadingType);
  }
  
  @override
  Widget buildAppBar() {
    TextField searchDield = TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: '搜索关键词'
      ),
      focusNode: _focusNode,
      controller: _textEditingController,
      onChanged: _onSearchFieldChange,
      onSubmitted: _onSearchFieldSubmitted,
    );

    return AppBar(
      title: searchDield,
      elevation: 0,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Stack(

      children: <Widget>[
        Offstage(
          offstage: _searchKey.isNotEmpty,
          child: _buildHotkeysCaontainer(),
        ),
        Offstage(
          offstage: _searchKey.isEmpty,
          child: _buildSearchResult(),
        ),
      ],
    );
  }
}