import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vincent_flutter/src/net/Address.dart';
import 'package:vincent_flutter/view/store/VState.dart';
import 'package:vincent_flutter/view/store/locale_redux.dart';
import 'package:vincent_flutter/view/store/theme_redux.dart';
import 'package:vincent_flutter/view/style/VCommonColors.dart';
import 'package:vincent_flutter/view/style/VCommonStyles.dart';
import 'package:vincent_flutter/view/utils/VMessageUtils.dart';
import 'package:vincent_flutter/view/utils/VNavigatorUtils.dart';
import 'package:vincent_flutter/view/widget/form/form_edit_dIalog.dart';
import 'package:vincent_flutter/view/widget/vw_flex_button.dart';

class VCommonUtils {
  ///列表item dialog
  static Future<Null> showCommitOptionDialog(
    BuildContext context,
    List<String> commitMaps,
    ValueChanged<int> onTap, {
    width = 250.0,
    height = 400.0,
    List<Color> colorList,
  }) {
    return VNavigatorUtils.showVWDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: new Container(
              width: width,
              height: height,
              padding: new EdgeInsets.all(4.0),
              margin: new EdgeInsets.all(20.0),
              decoration: new BoxDecoration(
                color: Color(VCommonColors.white),
                //用一个BoxDecoration装饰器提供背景图片
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: new ListView.builder(
                  itemCount: commitMaps.length,
                  itemBuilder: (context, index) {
                    return VWFlexButton(
                      maxLines: 1,
                      mainAxisAlignment: MainAxisAlignment.start,
                      fontSize: 14.0,
                      color: colorList != null ? colorList[index] : Theme.of(context).primaryColor,
                      text: commitMaps[index],
                      textColor: Color(VCommonColors.white),
                      onPress: () {
                        Navigator.pop(context);
                        onTap(index);
                      },
                    );
                  }),
            ),
          );
        });
  }

  static Future<Null> showLoadingDialog(BuildContext context) {
    return showLoadingDialogTxt(context, VMessageUtils.getLocale(context, "common.loading"));
  }

  static Future<Null> showLoadingDialogTxt(BuildContext context, String text) {
    return VNavigatorUtils.showVWDialog(
        context: context,
        builder: (BuildContext context) {
          return new Material(
              color: Colors.transparent,
              child: WillPopScope(
                onWillPop: () => new Future.value(false),
                child: Center(
                  child: new Container(
                    width: 200.0,
                    height: 200.0,
                    padding: new EdgeInsets.all(4.0),
                    decoration: new BoxDecoration(
                      color: Colors.transparent,
                      //用一个BoxDecoration装饰器提供背景图片
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(child: SpinKitCubeGrid(color: Color(VCommonColors.white))),
                        new Container(height: 10.0),
                        new Container(child: new Text(text, style: VCommonStyles.normalTextWhite)),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  void showAlertDialog({@required BuildContext context, String message, String title, String close, List<Widget> items}) {
    List<Widget> children = items ?? <Widget>[Text(message)];
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? '提示'),
          content: SingleChildScrollView(
            child: ListBody(children: children),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(close ?? '关闭'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<Null> showEditDialog(
    BuildContext context,
    String dialogTitle,
    ValueChanged<String> onTitleChanged,
    ValueChanged<String> onContentChanged,
    VoidCallback onPressed, {
    TextEditingController titleController,
    TextEditingController valueController,
    bool needTitle = true,
  }) {
    return VNavigatorUtils.showVWDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: new FormEditDialog(
              dialogTitle,
              onTitleChanged,
              onContentChanged,
              onPressed,
              titleController: titleController,
              valueController: valueController,
              needTitle: needTitle,
            ),
          );
        });
  }

  ///版本更新
  static Future<Null> showUpdateDialog(BuildContext context, String contentMsg) {
    return VNavigatorUtils.showVWDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(VMessageUtils.getLocale(context, "app.version.title")),
            content: new Text(contentMsg),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text(VMessageUtils.getLocale(context, "form.button.cancel"))),
              FlatButton(
                  onPressed: () {
                    launch(Address.update_url);
                    Navigator.pop(context);
                  },
                  child: new Text(VMessageUtils.getLocale(context, "form.button.ok")))
            ],
          );
        });
  }

  static Future pickImage(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    return image;
  }

  static void callTel(String tel) async {
    String url = "tel:$tel";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void callSMS(String sms) async {
    String url = "sms:$sms";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static pushTheme(Store store, int index) {
    ThemeData themeData;
    List<Color> colors = getThemeListColor();
    themeData = getThemeData(colors[index]);
    store.dispatch(new RefreshThemeDataAction(themeData));
  }

  static changeLocale(Store<VState> store, int index) {
    Locale locale = store.state.platformLocale;
    switch (index) {
      case 1:
        locale = Locale('zh', 'CH');
        break;
      case 2:
        locale = Locale('en', 'US');
        break;
    }
    store.dispatch(RefreshLocaleAction(locale));
  }

  static List<Color> getThemeListColor() {
    return [
      VCommonColors.primarySwatch,
      Colors.brown,
      Colors.blue,
      Colors.teal,
      Colors.amber,
      Colors.blueGrey,
      Colors.deepOrange,
    ];
  }

  static getThemeData(Color color) {
    return ThemeData(primarySwatch: color, platform: TargetPlatform.android);
  }
}
