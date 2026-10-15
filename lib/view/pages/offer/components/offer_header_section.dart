import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/custom_types/offer_plan_badge.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_details_labels_extension.dart';
import 'package:map_maker_new/utils/offer_labels_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/shared_components/widgets/plan_badge_widget.dart';

class OfferHeaderSection extends StatelessWidget {
  const OfferHeaderSection({super.key, required this.offerDetails});

  final OfferDetails offerDetails;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String subtitle = offerDetails.subtitle(localizations);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(offerDetails.title(localizations), style: textTheme.headingH3_24),
        if (subtitle.isNotEmpty) ...{
          Text(subtitle, style: textTheme.bodyBase16.copyWith(color: ColorConstants.textSecondary)),
        },
        _getPriceRow(context),
        Text(
          offerDetails.terms(localizations),
          style: textTheme.bodySmall14.copyWith(color: ColorConstants.textMuted, fontWeight: FontWeight.w400),
        ),
        PlanBadgeWidget(planBadge: OfferPlanBadge.fromOffer(offerDetails.offer), withHint: true, isMultiline: true),
      ].withVerticalElementsSpacing(8),
    );
  }

  Widget _getPriceRow(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String? pricePerMeter = offerDetails.offer.pricePerMeterLabel(localizations);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Flexible(child: Text(offerDetails.offer.priceLabel(localizations), style: textTheme.price28)),
        if (pricePerMeter != null) ...{
          Text(pricePerMeter, style: textTheme.bodySmall14.copyWith(color: ColorConstants.textMuted)),
        },
      ].withHorizontalElementsSpacing(8),
    );
  }
}
