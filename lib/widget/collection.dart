import 'package:flutter/material.dart';
import 'package:wan/assets/images.dart';

/// 自定义的收藏按钮
class CollectionView extends StatefulWidget {
  final initialCollected;
  final Function(bool) onChange;

  CollectionView({ this.initialCollected, this.onChange });

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
        var newCollected = !_collected;
        setState(() {
          _collected = newCollected;
        });
        widget.onChange(newCollected);
      },
      child: Container(
        child: Image.asset(imagePath, width: 24, height: 24),
      ),
    );
  }
}