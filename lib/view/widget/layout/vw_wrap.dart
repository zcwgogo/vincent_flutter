import 'package:flutter/material.dart';

class VWWrap extends StatelessWidget {
  final List<Widget> children;
  final double width;
  VWWrap({this.children,this.width});

  List<Widget> _buildItems() {
    List<Widget> result = List();
    int i = children.length-1;
    for (Widget widget in children) {
      var margin=EdgeInsets.zero;
      if (i != 0) {
        margin= EdgeInsets.only(right:10);
      }
      result.add(Container(margin:margin, width: width??80, child: widget));
      i++;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(children: _buildItems());
  }
}
