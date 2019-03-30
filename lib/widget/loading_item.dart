import 'package:flutter/material.dart';

/// 加载类型
enum LoadingType {
  /// 正常状态
  normal,
  /// 加载中
  loading,
  /// 已全部加载
  allLoaded,
  /// 暂无数据
  empty,
  /// 加载异常
  error,
}

/// 列表底部的加载状态条目
class LoadingItem extends StatelessWidget {
  final LoadingType type;
  final Function onReload;

  LoadingItem(this.type, { this.onReload });

  Widget _buildNormal() {
    return Text('上拉加载更多');
  }

  Widget _buildLoading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            strokeWidth: 1, 
            valueColor: AlwaysStoppedAnimation(Colors.black)
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 8),
          child: Text('正在加载..'),
        )
      ],
    );
  }

  Widget _buildAllLoaded() {
    return Text('已全部加载');
  }

  Widget _buildEmpty() {
    return Text('暂无数据');
  }

  Widget _buildError() {
    return InkWell(
      onTap: () {
        if (onReload != null) {
          onReload();
        }
      },
      child: Text('加载异常，点击重新加载'),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch(type) {
      case LoadingType.normal:
        child =_buildNormal();
        break;
      case LoadingType.loading:
        child =_buildLoading();
        break;
      case LoadingType.allLoaded:
        child =_buildAllLoaded();
        break;
      case LoadingType.empty:
        child =_buildEmpty();
        break;
      case LoadingType.error:
        child =_buildError();
        break;
    }

    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: child,
    );
  }
}