import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:vincent_flutter/src/model/Release.dart';
import 'package:vincent_flutter/view/utils/VCommonUtils.dart';
import 'package:vincent_flutter/view/utils/VMessageUtils.dart';

class ReposDao {
  /**
   * 版本更新
   */
  static getNewsVersion(context, showTip) async {
    if (Platform.isIOS) {
      return;
    }
    Release release = Release.create(1, "测试版本", "修改了诸多问题", "1.0.1", DateTime.now(), DateTime.now());
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var appVersion = packageInfo.version;
    Version versionNameNum = Version.parse(release.version);
    Version currentNum = Version.parse(appVersion);
    int result = versionNameNum.compareTo(currentNum);
    if (result > 0) {
      VCommonUtils.showUpdateDialog(context, release.name + ": " + release.body);
    } else {
      if (showTip) Fluttertoast.showToast(msg: VMessageUtils.getLocale(context, "app.version.new"));
    }
  }
}
