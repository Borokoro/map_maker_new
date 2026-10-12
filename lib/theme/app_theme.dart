import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/app_constants.dart';
import 'package:map_maker_new/constants/color_constants.dart';

ThemeData appTheme(BuildContext context) {
  final ThemeData themeData = ThemeData.light(useMaterial3: true);
  return themeData.copyWith(
    textTheme: themeData.textTheme.apply(fontFamily: AppConstants.defaultFont, bodyColor: ColorConstants.textPrimary),
    scaffoldBackgroundColor: ColorConstants.bgSurface,
  );
}