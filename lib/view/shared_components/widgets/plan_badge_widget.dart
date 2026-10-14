import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/custom_types/offer_plan_badge.dart';
import 'package:map_maker_new/types/enum/plan_badge_tone.dart';
import 'package:map_maker_new/utils/offer_labels_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class PlanBadgeWidget extends StatelessWidget {
  const PlanBadgeWidget({
    super.key,
    required this.planBadge,
    this.withHint = false,
  });

  final OfferPlanBadge planBadge;
  final bool withHint;

  static const double _dotSize = 6;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Color contentColor = _getContentColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: StyleConstants.radius100,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _dotSize,
            height: _dotSize,
            decoration: BoxDecoration(color: contentColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              planBadge.label(localizations, withHint: withHint),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.caption12.copyWith(color: contentColor),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (planBadge.tone) {
      case PlanBadgeTone.success:
      case PlanBadgeTone.nature:
        return ColorConstants.bgSuccessSoft;
      case PlanBadgeTone.brand:
        return ColorConstants.bgBrandSoft;
      case PlanBadgeTone.warning:
        return ColorConstants.bgWarningSoft;
      case PlanBadgeTone.neutral:
        return ColorConstants.bgSurfaceAlt;
    }
  }

  Color _getContentColor() {
    switch (planBadge.tone) {
      case PlanBadgeTone.success:
      case PlanBadgeTone.nature:
        return ColorConstants.textSuccess;
      case PlanBadgeTone.brand:
        return ColorConstants.textBrand;
      case PlanBadgeTone.warning:
        return ColorConstants.textWarning;
      case PlanBadgeTone.neutral:
        return ColorConstants.textSecondary;
    }
  }
}
