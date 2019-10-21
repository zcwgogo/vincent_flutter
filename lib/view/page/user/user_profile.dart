import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vincent_flutter/src/dao/UserDao.dart';
import 'package:vincent_flutter/src/model/User.dart';
import 'package:vincent_flutter/view/style/VCommonStyles.dart';
import 'package:vincent_flutter/view/style/VIconConstant.dart';
import 'package:vincent_flutter/view/utils/VCommonUtils.dart';
import 'package:vincent_flutter/view/utils/VMessageUtils.dart';
import 'package:vincent_flutter/view/widget/vw_card_item.dart';


const String user_profile_name = "名字";
const String user_profile_email = "邮箱";
const String user_profile_link = "链接";
const String user_profile_org = "公司";
const String user_profile_location = "位置";
const String user_profile_info = "简介";

class UserProfileInfo extends StatefulWidget {
  UserProfileInfo();

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfileInfo> {
  _renderItem(
      IconData leftIcon, String title, String value, VoidCallback onPressed) {
    return new VWCardItem(
      child: new RawMaterialButton(
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.all(15.0),
        constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
        child: new Row(
          children: <Widget>[
            new Icon(leftIcon),
            new Container(
              width: 10.0,
            ),
            new Text(title, style: VCommonStyles.normalSubText),
            new Container(
              width: 10.0,
            ),
            new Expanded(child: new Text(value, style: VCommonStyles.normalText)),
            new Container(
              width: 10.0,
            ),
            new Icon(VIconConstant.DEFAULT_FORM_ITEM, size: 12.0),
          ],
        ),
      ),
    );
  }

  _showEditDialog(String title, String value, String key, Store store) {
    String content = value ?? "";
    VCommonUtils.showEditDialog(context, title, (title) {}, (res) {
      content = res;
    }, () {
      if (content == null || content.length == 0) {
        return;
      }
      VCommonUtils.showLoadingDialog(context);

      UserDao.updateUserDao({key: content}, store).then((res) {
        Navigator.of(context).pop();
        if (res != null && res.result) {
          Navigator.of(context).pop();
        }
      });
    },
        titleController: new TextEditingController(),
        valueController: new TextEditingController(text: value),
        needTitle: false);
  }

  List<Widget> _renderList(User userInfo, Store store) {
    return [
      _renderItem(Icons.info, VMessageUtils.getLocale(context,"user_profile_name"),
          userInfo.name ?? "---", () {
        _showEditDialog(VMessageUtils.getLocale(context,"user_profile_name"),
            userInfo.name, "name", store);
      }),
      _renderItem(
          Icons.email,
          VCommonUtils.getLocale(context,"user_profile_email"),
          userInfo.email ?? "---", () {
        _showEditDialog(VCommonUtils.getLocale(context,"user_profile_email"),
            userInfo.email, "email", store);
      }),
      _renderItem(Icons.link, VCommonUtils.getLocale(context,"user_profile_link"),
          userInfo.blog ?? "---", () {
        _showEditDialog(VCommonUtils.getLocale(context,"user_profile_link"),
            userInfo.blog, "blog", store);
      }),
      _renderItem(Icons.group, VCommonUtils.getLocale(context,"user_profile_org"),
          userInfo.company ?? "---", () {
        _showEditDialog(VCommonUtils.getLocale(context,"user_profile_org"),
            userInfo.company, "company", store);
      }),
      _renderItem(
          Icons.location_on,
          VMessageUtils.getLocale(context,"user_profile_location"),
          userInfo.location ?? "---", () {
        _showEditDialog(VMessageUtils.getLocale(context,"user_profile_location"),
            userInfo.location, "location", store);
      }),
      _renderItem(
          Icons.message,
          VMessageUtils.getLocale(context,"user_profile_info"),
          userInfo.bio ?? "---", () {
        _showEditDialog(VMessageUtils.getLocale(context,"user_profile_info"),
            userInfo.bio, "bio", store);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<GSYState>(builder: (context, store) {
      return Scaffold(
        appBar: new AppBar(
            title: new Hero(
                tag: "home_user_info",
                child: new Material(
                    color: Colors.transparent,
                    child: new Text(
                      VCommonUtils.getLocale(context).home_user_info,
                      style: GSYConstant.normalTextWhite,
                    )))),
        body: new Container(
          color: Color(GSYColors.white),
          child: new SingleChildScrollView(
            child: new Column(
              children: _renderList(store.state.userInfo, store),
            ),
          ),
        ),
      );
    });
  }
}
