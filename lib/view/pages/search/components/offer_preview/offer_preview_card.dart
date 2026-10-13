import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/custom_types/offer_plan_badge.dart';
import 'package:map_maker_new/types/models/offer.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_labels_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/pages/search/components/offer_preview/offer_thumbnail.dart';
import 'package:map_maker_new/view/pages/search/components/offer_preview/plan_badge_widget.dart';

class OfferPreviewCard extends StatelessWidget {
  const OfferPreviewCard({
    super.key,
    required this.offer,
  });

  final Offer offer;

  static const double height = 120;
  static const double _thumbnailSize = 96;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: ColorConstants.bgSurface,
        borderRadius: StyleConstants.radius17,
        boxShadow: StyleConstants.mapElementShadow,
      ),
      child: Row(
        children: [
          OfferThumbnail(
            size: _thumbnailSize,
            photoUrl: offer.coverPhotoUrl,
            geometry: offer.previewGeojson,
          ),
          Expanded(child: _getDetails(context)),
        ].withHorizontalElementsSpacing(12),
      ),
    );
  }

  Widget _getDetails(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getPriceRow(context),
        Text(
          offer.metaLabel(localizations),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodySmall14.copyWith(
            color: ColorConstants.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        PlanBadgeWidget(planBadge: OfferPlanBadge.fromOffer(offer), withHint: true),
      ].withVerticalElementsSpacing(6),
    );
  }

  Widget _getPriceRow(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String? pricePerMeter = offer.pricePerMeterLabel(localizations);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Flexible(
          child: Text(
            offer.priceLabel(localizations),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headingH4_20,
          ),
        ),
        if (pricePerMeter != null)
          Text(
            pricePerMeter,
            style: textTheme.caption12.copyWith(color: ColorConstants.textMuted),
          ),
      ].withHorizontalElementsSpacing(6),
    );
  }
}
