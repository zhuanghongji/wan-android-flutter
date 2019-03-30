import 'package:flutter/material.dart';
import 'package:wan/assets/images.dart';

/// 自定义的收藏按钮
class CollectionView extends StatefulWidget {
  final initialCollected;
  final Function(bool) onChange;

  /// 是否锁定显示
  /// 
  /// - 当处于锁定状态时（即 [isLocked] 为 `true`），点击该按钮时 [onChange] 方法回调时参数的值始终为 [initialCollected]
  /// - 当处于非锁定状态时（即 [isLocked] 为 `false`），点击按钮会切换收藏状态并在回调 [onChange] 时传递最新的参数值
  final bool isLocked;

  CollectionView({ this.initialCollected, this.onChange, this.isLocked = false});

  @override
  _CollectionViewState createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {
  bool _collected = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _collected = widget.initialCollected;
    });
  }

  @override
  Widget build(BuildContext context) {
    var imagePath = _collected ? ImageAsset.icStartSolid : ImageAsset.icStartHollow; 
    return InkWell(
      onTap: () {
        if (widget.isLocked) {
          widget.onChange(widget.initialCollected);
          return;
        }
        var newCollected = !_collected;
        setState(() {
          _collected = newCollected;
        });
        widget.onChange(newCollected);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Image.asset(imagePath, width: 18, height: 18),
      ),
    );
  }
}