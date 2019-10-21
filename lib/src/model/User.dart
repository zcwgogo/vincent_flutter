import 'package:vincent_flutter/view/style/VIconConstant.dart';

class User {
  String account;
  String name;
  String email;
  String avatar;
  String phone;
  String status;
  String userType;
  String lastLoginTime;
  int id;


  User();

  User.fromMap(Map map){
    this.account=map["account"];
    this.email=map["email"];
    this.name=map["userName"];
    this.avatar=map["avatar"];
    this.phone=map["phone"];
    this.status=map["status"];
    this.userType=map["userType"];
    this.lastLoginTime=map["lastLoginTime"];
    this.id=map["id"];
  }

  static empty() {
    return  User();
  }
}
