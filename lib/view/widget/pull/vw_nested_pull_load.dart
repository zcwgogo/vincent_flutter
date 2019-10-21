import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vincent_flutter/view/style/VCommonStyles.dart';
import 'package:vincent_flutter/view/widget/form/item/vw_date_pick.dart';
import 'package:vincent_flutter/view/widget/form/item/vw_date_range.dart';
import 'package:vincent_flutter/view/widget/form/item/vw_number.dart';
import 'package:vincent_flutter/view/widget/form/item/vw_select.dart';
import 'package:vincent_flutter/view/widget/form/item/vw_text.dart';
import 'package:vincent_flutter/view/widget/form/vw_form.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item_option.dart';
import 'package:vincent_flutter/view/widget/pull/pull_load_widgetBase.dart';

import 'pull_load_state_base.dart';
import 'vw_pull_load_control.dart';

class VWNestedPullLoad extends StatefulWidget with PullLoadWidgetBase {
  final IndexedWidgetBuilder _itemBuilder;
  final VWPullLoadControl _control;
  final ScrollController _scrollController = new ScrollController();

  VWNestedPullLoad(this._control, this._itemBuilder);

  @override
  ScrollController getScrollController() {
    return _scrollController;
  }

  @override
  _VWNestedPullLoadState createState() {
    return _VWNestedPullLoadState(this._control, this._itemBuilder, this._scrollController);
  }
}

class _VWNestedPullLoadState extends State<VWNestedPullLoad> with PullLoadStateBase, SingleTickerProviderStateMixin {
  final IndexedWidgetBuilder _itemBuilder;
  VWPullLoadControl _control;
  ScrollController _scrollController;

  _VWNestedPullLoadState(this._control, this._itemBuilder, this._scrollController);

  @override
  VWPullLoadControl getPullLoadControl() {
    return _control;
  }

  @override
  ScrollController getScrollController() {
    return _scrollController;
  }

  @override
  IndexedWidgetBuilder getItemBuilder() {
    return _itemBuilder;
  }

  @override
  void refreshState(callBack) {
    setState(callBack);
  }

  @override
  void dispose() {
    super.widgetDispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initWidgetState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: NestedScrollView(
              headerSliverBuilder: _sliverBuilder,
              body: RefreshIndicator(
                  onRefresh: requestRefresh,
                  child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return super.getItem(_, index);
                      },
                      itemCount: super.getListCount(),
                      controller: _scrollController)))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          _scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.linear);
        },
        tooltip: 'Increment Counter',
        child: Icon(Icons.arrow_upward),
      ),
      endDrawer: Drawer(
        child: VWForm(
          onSubmit: (targetObj){
            Navigator.pop(context);
            super.requestRefresh(param:targetObj.getValues());
          },
          children:<VWFormItem>[
            VWText(option: VWFormItemOption.createInput("name","名称", "请输入名称")),
            VWText(option: VWFormItemOption.createInput("sex","性别", "请输入性别")),
            VWSelect(option: VWFormItemOption.createSelect("status","状态", "YES_OR_NO")),
            VWNumber(option: VWFormItemOption.createInput("quantity","数量", "请选择数量")),
            VWDatePick(option: VWFormItemOption.createDate("releaseDate","发布日期",)),
            VWDateRange(option: VWFormItemOption.createDate("releaseDateRange","日期区间")),
          ] ,
        ),
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        actions: <Widget>[
          PopupMenuButton<String>(
            child: new Row(children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 3),
                child: Text('最新创建', style: VCommonStyles.smallTextWhite),
              ),
              Icon(FontAwesomeIcons.sort, color: Colors.white, size: 15)
            ]),
            onSelected: (String choose) {},
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  PopupMenuItem(value: "updateTime", child: Text("最新更新")),
                  PopupMenuItem(value: "createTime", child: Text("最新创建"))
                ],
          ),
          RawMaterialButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            padding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 3),
            child: Row(children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 3),
                child: Text('筛选', style: VCommonStyles.smallTextWhite),
              ),
              Icon(FontAwesomeIcons.filter, color: Colors.white, size: 11)
            ]),
          )
        ],
//        leading:  Container(),
        floating: true,
      ),
    ];
  }
}
