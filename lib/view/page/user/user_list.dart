import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:vincent_flutter/src/model/EventViewModel.dart';
import 'package:vincent_flutter/src/net/Address.dart';
import 'package:vincent_flutter/view/style/VIconConstant.dart';
import 'package:vincent_flutter/view/widget/pull/vw_nested_pull_load.dart';
import 'package:vincent_flutter/view/widget/pull/vw_pull_load_control.dart';
import 'package:vincent_flutter/view/widget/vw_event_item.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  var _pullLoad;
  VWPullLoadControl _control;

  _renderItem(e) {
    String avatar = e["avatar"] ?? VIconConstant.DEFAULT_USER_ICON;
    EventViewModel vm = new EventViewModel(e["account"], avatar, e["name"], e["createTime"], "");
    return new VWEventItem(
      vm,
      onPressed: () {
        LogUtil.v("press item.");
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _control = new VWPullLoadControl();
    _control.url = Address.getUserURL("list");
    _pullLoad = VWNestedPullLoad(_control, (BuildContext context, int index) => _renderItem(_control.dataList[index]));
    return _pullLoad;
  }
}
