import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/custom_types/offer_plan_badge.dart';
import 'package:map_maker_new/utils/offer_labels_extension.dart';
import 'package:map_maker_new/utils/plan_badge_tone_colors_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class PlanBadgeWidget extends StatelessWidget {
  const PlanBadgeWidget({
    super.key,
    required this.planBadge,
    this.withHint = false,
    this.isMultiline = false,
  });

  final OfferPlanBadge planBadge;
  final bool withHint;
  final bool isMultiline;

  static const double _dotSize = 6;
  static const double _multilineDotOffset = 5;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Color contentColor = planBadge.tone.contentColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: planBadge.tone.backgroundColor,
        borderRadius: isMultiline ? StyleConstants.radius12 : StyleConstants.radius100,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: isMultiline ? _multilineDotOffset : 0),
            child: Container(
              width: _dotSize,
              height: _dotSize,
              decoration: BoxDecoration(color: contentColor, shape: BoxShape.circle),
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              planBadge.label(localizations, withHint: withHint),
              maxLines: isMultiline ? null : 1,
              overflow: isMultiline ? null : TextOverflow.ellipsis,
              style: textTheme.caption12.copyWith(color: contentColor),
            ),
          ),
        ],
      ),
    );
  }
}
