import 'package:vincent_flutter/src/dao/UserDao.dart';

class VMenu {
  int id;
  String name;
  String iconCls;
  int parentId;
  List<VMenu> children;

  VMenu({this.id, this.name, this.iconCls, this.parentId});

  VMenu.fromJSON(Map json)
      : id = json['id'],
        name = json['name'],
        iconCls = json['iconCls'],
        parentId = json['parentId'];

  VMenu generateItem(VMenu menu, Map json) {
    List<VMenu> children = List();
    for (Map obj in json["children"]) {
      children.add(VMenu.fromJSON(obj));
    }
    menu.children = children;
    return menu;
  }
}

class MenuControl {
  Future<List<VMenu>> mainList() async {
    Map userInfo=await UserDao.getUserInfoLocal();
    List menus = userInfo["menus"];
    List<VMenu> result = menus.map((json) {
      VMenu menu = VMenu.fromJSON(json);
      return menu.generateItem(menu, json);
    }).toList();
    return result;
  }
}
