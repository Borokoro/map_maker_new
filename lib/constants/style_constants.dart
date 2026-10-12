import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';

abstract class StyleConstants {
  static const EdgeInsets edgeInsetsH20 = EdgeInsets.symmetric(horizontal: 20);

  static const BorderRadius radius17 = BorderRadius.all(Radius.circular(17));
  static const Border borderT1 = Border(
    top: BorderSide(color: ColorConstants.borderDefault, width: 1),
  );
  static const Border borderB1 = Border(
    bottom: BorderSide(color: ColorConstants.borderDefault, width: 1),
  );
}
