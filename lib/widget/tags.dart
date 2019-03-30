import 'package:flutter/material.dart';
import 'package:wan/api/datas/tag.dart';

/// 标签列表部件
class Tags extends StatelessWidget {
  final List<Tag> tags;

  Tags(this.tags);

  Widget _buildTag(Tag tag) {
    return Container(
      padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Text(
        tag.name, 
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Row(
        children: tags.map((tag) => _buildTag(tag)).toList(),
      ),
    );
  }
}