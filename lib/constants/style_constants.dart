import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';

abstract class StyleConstants {
  static const EdgeInsets edgeInsetsH20 = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets edgeInsetsH16 = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets edgeInsetsH12 = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets edgeInsets16 = EdgeInsets.all(16);
  static const EdgeInsets edgeInsets12 = EdgeInsets.all(12);
  static const EdgeInsets edgeInsets20 = EdgeInsets.all(20);
  static const EdgeInsets edgeInsetsL48 = EdgeInsets.only(left: 48);
  static const EdgeInsets edgeInsetsH10V4 = EdgeInsets.symmetric(horizontal: 10, vertical: 4);
  static const EdgeInsets edgeInsetsH16V20 = EdgeInsets.symmetric(horizontal: 16, vertical: 20);
  static const EdgeInsets edgeInsetsH20V24 = EdgeInsets.symmetric(horizontal: 20, vertical: 24);
  static const EdgeInsets edgeInsetsH24V32 = EdgeInsets.symmetric(horizontal: 24, vertical: 32);
  static const EdgeInsets edgeInsetsH24B16 = EdgeInsets.fromLTRB(24, 0, 24, 16);
  static const EdgeInsets edgeInsetsH16V14 = EdgeInsets.symmetric(horizontal: 16, vertical: 14);
  static const EdgeInsets edgeInsetsH20V12 = EdgeInsets.symmetric(horizontal: 20, vertical: 12);
  static const EdgeInsets edgeInsetsH16T12 = EdgeInsets.fromLTRB(16, 12, 16, 0);

  static const BorderRadius radius12 = BorderRadius.all(Radius.circular(12));
  static const BorderRadius radius17 = BorderRadius.all(Radius.circular(17));
  static const BorderRadius radius100 = BorderRadius.all(Radius.circular(100));
  static const BorderRadius radiusT20 = BorderRadius.vertical(top: Radius.circular(20));
  static const Border borderT1 = Border(
    top: BorderSide(color: ColorConstants.borderDefault, width: 1),
  );
  static const Border borderB1 = Border(
    bottom: BorderSide(color: ColorConstants.borderDefault, width: 1),
  );

  static const List<BoxShadow> mapElementShadow = [
    BoxShadow(color: Color(0x1F0B1220), blurRadius: 12, offset: Offset(0, 2)),
  ];
}
