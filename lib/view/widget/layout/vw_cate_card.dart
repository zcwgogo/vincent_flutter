import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/style/VIconString.dart';
import 'package:vincent_flutter/view/widget/layout/vw_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './vw_item_container.dart';

class VWCateCard extends StatefulWidget {
  final VMenu category;

  VWCateCard(this.category);

  @override
  _CateCardState createState() => _CateCardState();
}

class _CateCardState extends State<VWCateCard> {
  MenuControl catControl = new MenuControl();
  List<VMenu> _menuList;

  @override
  void initState() {
    super.initState();
    _menuList = widget.category.children;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: screenWidth - 20,
            margin: const EdgeInsets.only(top: 30.0, bottom: 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: screenWidth - 20,
                  padding: const EdgeInsets.only(left: 65.0, top: 3.0),
                  height: 30.0,
                  child: Text(
                    widget.category.name,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                _buildWidgetContainer(),
              ],
            ),
          ),
          Positioned(
            left: 0.0,
            top: 0.0,
            child: Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(23.0),
                  ),
                  height: 46.0,
                  width: 46.0,
                  child: Icon(
                    VIconString.icons[widget.category.name]??FontAwesomeIcons.calendarMinus,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWidgetContainer() {
    if (this._menuList.length == 0) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/paimaiLogo.png'), alignment: Alignment.bottomRight),
      ),
      child: WidgetItemContainer(categories: this._menuList, columnCount: 3, isWidgetPoint: false),
    );
  }
}
