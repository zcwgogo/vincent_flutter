import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/style/VCommonColors.dart';

class VCommonStyles {
  static const normalTextSize = 18.0;
  static const smallTextSize = 14.0;
  static const middleTextWhiteSize = 16.0;
  static const bigTextSize = 23.0;

  static const normalTextLight = TextStyle(
    color: Color(VCommonColors.primaryLightValue),
    fontSize: normalTextSize,
  );
  static const largeTextWhite = TextStyle(
    color: Color(VCommonColors.textColorWhite),
    fontSize: bigTextSize,
  );
  static const normalText = TextStyle(
    color: Color(VCommonColors.mainTextColor),
    fontSize: normalTextSize,
  );
  static const normalTextBold = TextStyle(
    color: Color(VCommonColors.mainTextColor),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );
  static const smallSubText = TextStyle(
    color: Color(VCommonColors.subTextColor),
    fontSize: smallTextSize,
  );
  static const smallTextWhite = TextStyle(
    color: Color(VCommonColors.white),
    fontSize: smallTextSize,
  );
  static const smallTextBold = TextStyle(
    color: Color(VCommonColors.mainTextColor),
    fontSize: smallTextSize,
    fontWeight: FontWeight.bold,
  );
  static const normalTextWhite = TextStyle(
    color: Color(VCommonColors.textColorWhite),
    fontSize: normalTextSize,
  );
  static const middleTextWhite = TextStyle(
    color: Color(VCommonColors.textColorWhite),
    fontSize: middleTextWhiteSize,
  );
  static const middleSubLightText = TextStyle(
    color: Color(VCommonColors.subLightTextColor),
    fontSize: middleTextWhiteSize,
  );
  static const normalSubText = TextStyle(
    color: Color(VCommonColors.subTextColor),
    fontSize: normalTextSize,
  );
  static const middleSubText = TextStyle(
    color: Color(VCommonColors.subTextColor),
    fontSize: middleTextWhiteSize,
  );
  static const middleText = TextStyle(
    color: Color(VCommonColors.mainTextColor),
    fontSize: middleTextWhiteSize,
  );
}
