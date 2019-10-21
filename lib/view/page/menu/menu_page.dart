import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/style/VCommonColors.dart';
import 'package:vincent_flutter/view/widget/layout/vw_cate_card.dart';
import 'package:vincent_flutter/view/widget/layout/vw_menu.dart';

class MenuPage extends StatefulWidget {
  final MenuControl catModel;

  MenuPage()
      : catModel = new MenuControl(),
        super();

  @override
  _MenuPageState createState() => new _MenuPageState(catModel);
}

class _MenuPageState extends State<MenuPage> with AutomaticKeepAliveClientMixin {
  final MenuControl catModel;

  _MenuPageState(this.catModel) : super();

  TextEditingController controller;
  List<VMenu> categories = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    renderCats();
  }

  void renderCats() {
    catModel.mainList().then((List data) {
      if (data.isNotEmpty) {
        setState(() {
          categories = data;
        });
      }
    });

  }

  Widget buildGrid() {
    List<Widget> tiles = [];
    for (VMenu item in categories) {
      tiles.add(new VWCateCard(item));
    }
    return new ListView(
      children: tiles,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (categories.length == 0) {
      return ListView(
        children: <Widget>[new Container()],
      );
    }
    return Container(
      color: Color.fromRGBO(239, 239, 239, 10),
      child: this.buildGrid(),
    );
  }
}
