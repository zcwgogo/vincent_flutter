import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vincent_flutter/src/net/Address.dart';

class VIconConstant {
  static const String DEFAULT_USER_ICON = 'assets/images/logo.png';
  static const String DEFAULT_REMOTE_PIC = Address.url_host+'images/pc/avatar1.jpg';

  static const IconData DEFAULT_FORM_ITEM = FontAwesomeIcons.edit;

  static const IconData MAIN_HOME = FontAwesomeIcons.checkSquare;
  static const IconData MAIN_MENU = FontAwesomeIcons.thLarge;
  static const IconData MAIN_MESSAGE = FontAwesomeIcons.commentDots;
  static const IconData MAIN_MY = FontAwesomeIcons.userMd;
  static const IconData MAIN_SEARCH = FontAwesomeIcons.search;
}