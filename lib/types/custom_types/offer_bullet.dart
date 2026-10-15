import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';

class OfferBullet extends Equatable {
  final String text;
  final IconData icon;
  final Color color;

  const OfferBullet.positive(this.text) : icon = IconConstants.check, color = ColorConstants.textSuccess;

  const OfferBullet.warning(this.text) : icon = IconConstants.warning, color = ColorConstants.textWarning;

  const OfferBullet.info(this.text) : icon = IconConstants.info, color = ColorConstants.textSecondary;

  @override
  List<Object?> get props => [text, icon, color];
}
