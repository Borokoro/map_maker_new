import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/types/enum/plan_badge_tone.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/plan_badge_tone_colors_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class OfferToneBadge extends StatelessWidget {
  const OfferToneBadge({super.key, required this.text, required this.tone, this.icon});

  final String text;
  final PlanBadgeTone tone;
  final IconData? icon;

  static const double _iconSize = 14;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final IconData? badgeIcon = icon;

    return Container(
      padding: StyleConstants.edgeInsetsH10V4,
      decoration: BoxDecoration(color: tone.backgroundColor, borderRadius: StyleConstants.radius100),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (badgeIcon != null) ...{
            Icon(badgeIcon, size: _iconSize, color: tone.contentColor),
          },
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.caption12.copyWith(color: tone.contentColor),
            ),
          ),
        ].withHorizontalElementsSpacing(4),
      ),
    );
  }
}
