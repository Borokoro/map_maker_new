import 'dart:ui';

import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/types/enum/plan_badge_tone.dart';

extension PlanBadgeToneColorsExtension on PlanBadgeTone {
  Color get backgroundColor {
    switch (this) {
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

  Color get contentColor {
    switch (this) {
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
