import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan/assets/images.dart';

const _TAG = 'BasePAge:';

/// 当前页面的加载状态
class _LoadingState {
  /// 正常
  static const normal = 'normal';
  /// 加载中
  static const loading = 'loading';
  /// 暂无数据
  static const empty = 'empty';
  /// 加载异常
  static const error = 'error';
}

/// BasePage 或 BasePageState 相关常量
class _BaseConstant {
  static const emptyTip = '暂无数据';
  static const emptyImagePath = ImageAsset.icEmpty;
  static const errorTip = '点击重新加载';
  static const errorImagePath = ImageAsset.icErrorText;
}

/// Base Page
abstract class BasePage extends StatefulWidget {
  BasePageState getPageState();

  @override
  BasePageState createState() => getPageState();
}

/// Base Page State
abstract class BasePageState<T extends BasePage> extends State<T> {
  /// true 显示应用栏；false 不显示
  bool _isShowAppBar = true;

  String _loadingState = _LoadingState.loading;
  String _emptyTip = _BaseConstant.emptyTip;
  String _emptyImagePath = _BaseConstant.emptyImagePath;
  String _errorTip = _BaseConstant.errorTip;
  String _errorImagePath = _BaseConstant.errorImagePath;

  // MARK: methods.

  /// 设置应用栏是否显示
  /// 
  /// 当 [visible] 为 true 时显示，否则不显示。
  void setAppBarVisible(bool visible) {
    setState(() {
      _isShowAppBar = visible;
    });
  }

  /// 设置暂无数据时显示的内容
  /// 
  /// - [tip] 提示语
  /// - [imagePath] 图片
  void setupEmpty({ 
    String tip = _BaseConstant.emptyTip,
    String imagePath = _BaseConstant.emptyImagePath,
  }) {
    setState(() {
      _emptyTip = tip;
      _emptyImagePath = imagePath;
    });
  }

  /// 设置加载异常时显示的内容
  /// 
  /// - [tip] 提示语
  /// - [imagePath] 图片
  void setupError({ 
    String tip = _BaseConstant.errorTip,
    String imagePath = _BaseConstant.errorImagePath,
  }) {
    setState(() {
      _errorTip = tip;
      _errorImagePath = imagePath;
    });
  }

  /// 显示内容
  void showContent() {
    setState(() {
      _loadingState =_LoadingState.normal;
    });
  }

  /// 显示加载中
  void showLoading() {
    setState(() {
      _loadingState =_LoadingState.loading;
    });
  }

  /// 显示暂无数据
  void showEmpty() {
    setState(() {
      _loadingState =_LoadingState.empty;
    });
  }

  /// 显示加载异常
  void showError() {
    setState(() {
      _loadingState =_LoadingState.error;
    });
  }


  // MARK: listeners.

  /// 当加载异常时，如果用户点击对应部件的话会回调此方法
  void onErrorTap() {
    print('$_TAG onErrorTap');
  }
  
  /// 当暂无数据时，如果用户点击对应部件的话会回调此方法
  void onEmptyTap() {
    print('$_TAG onEmptyTap');
  }

  // MARK: build.
  
  /// 抽象方法，由具体 Page 来实现此方法来获取显示内容
  Widget buildContent(BuildContext context);

  /// 抽象方法，由具体 Page 来实现此方法来获取应用栏
  Widget buildAppBar();

  /// 构建加载部件，具体 Page 可覆写该方法进行定制
  Widget buildLoading() {
    return Center(
      child: CupertinoActivityIndicator (
      radius: 15.0, // 值越大加载的图形越大
    ));
  }

  /// 构建加载部件，具体 Page 可覆写该方法进行定制
  Widget buildEmpty() {
    return Center(
      child: InkWell(
        onTap: onErrorTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(_emptyImagePath),
            Text(
              _emptyTip, 
              style: TextStyle(color: Color(int.parse('0x9E9E9'))),
            )
          ],
        ),
      )
    );
  }

  Widget buildError() {
    return Center(
      child: InkWell(
        onTap: onErrorTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(_errorImagePath),
            Text(
              _errorTip, 
              style: TextStyle(color: Color(int.parse('0x9E9E9'))),
            )
          ],
        ),
      )
    );
  }

  // MARK: build base.

  /// 对应 [buildAppBar] 方法，主要用于控制是否构建 
  PreferredSize _buildBaseAppBar() {
    return PreferredSize(
      child: Offstage(
        offstage: !_isShowAppBar,
        child: buildAppBar(),
      ),
      preferredSize: Size.fromHeight(50)
    );
  }

  Widget _buildBaseLoading() {
    return Offstage(
      offstage: _LoadingState.loading != _loadingState,
      child: buildLoading(),
    );
  }

  Widget _buildBaseEmpty() {
    return Offstage(
      offstage: _LoadingState.empty != _loadingState,
      child: buildEmpty(),
    );
  }

  Widget _buildBaseError() {
    return Offstage(
      offstage: _LoadingState.error != _loadingState,
      child: buildError(),
    );
  }

  // MARK: override.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBaseAppBar(),
      body: Container(
        child: Stack(
          children: <Widget>[
            buildContent(context),
            _buildBaseLoading(),
            _buildBaseEmpty(),
            _buildBaseError(),
          ],
        ),
      ),
    );
  }
}