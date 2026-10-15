import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/types/enum/plan_badge_tone.dart';
import 'package:map_maker_new/utils/plan_badge_tone_colors_extension.dart';

class OfferCardContainer extends StatelessWidget {
  const OfferCardContainer({super.key, required this.child, this.tone, this.padding = StyleConstants.edgeInsets16});

  final Widget child;
  final PlanBadgeTone? tone;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final PlanBadgeTone? cardTone = tone;

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: cardTone?.backgroundColor ?? ColorConstants.bgSurface,
        borderRadius: StyleConstants.radius17,
        border: Border.all(color: ColorConstants.borderDefault),
      ),
      child: child,
    );
  }
}
