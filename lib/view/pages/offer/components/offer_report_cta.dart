import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/enum/plan_badge_tone.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_card_container.dart';
import 'package:map_maker_new/view/shared_components/widgets/primary_button.dart';

class OfferReportCta extends StatelessWidget {
  const OfferReportCta({super.key, required this.hasReport, required this.onOpenReportPressed});

  final bool hasReport;
  final VoidCallback onOpenReportPressed;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return OfferCardContainer(
      tone: PlanBadgeTone.brand,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(localizations.offerReportCtaTitle, style: textTheme.bodyLarge18.copyWith(fontWeight: FontWeight.w600)),
          Text(
            localizations.offerReportCtaBody,
            style: textTheme.bodySmall14.copyWith(color: ColorConstants.textSecondary, fontWeight: FontWeight.w400),
          ),
          if (hasReport) ...{
            PrimaryButton(text: localizations.offerReportCtaButton, onPressed: onOpenReportPressed),
          } else ...{
            Text(
              localizations.offerReportCtaPending,
              style: textTheme.bodySmall14.copyWith(color: ColorConstants.textMuted),
            ),
          },
        ].withVerticalElementsSpacing(12),
      ),
    );
  }
}
