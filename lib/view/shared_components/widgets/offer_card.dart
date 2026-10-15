import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/custom_types/offer_plan_badge.dart';
import 'package:map_maker_new/types/models/offer.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_labels_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/shared_components/widgets/offer_save_button.dart';
import 'package:map_maker_new/view/shared_components/widgets/offer_thumbnail/offer_thumbnail.dart';
import 'package:map_maker_new/view/shared_components/widgets/offer_utilities_widget.dart';
import 'package:map_maker_new/view/shared_components/widgets/plan_badge_widget.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
    required this.offer,
    required this.onSavePressed,
    required this.onPressed,
  });

  final Offer offer;
  final VoidCallback onSavePressed;
  final VoidCallback onPressed;

  static const double _mediaHeight = 176;
  static const double _mediaGeometryPadding = 32;
  static const double _plotsIconSize = 14;
  static const double _plotsChipOffset = 12;
  static const double _saveButtonOffset = 8;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: _getCard(context),
    );
  }

  Widget _getCard(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ColorConstants.bgSurface,
        borderRadius: StyleConstants.radius17,
        border: Border.all(color: ColorConstants.borderDefault),
        boxShadow: StyleConstants.mapElementShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getMedia(context),
          _getDetails(context),
        ],
      ),
    );
  }

  Widget _getMedia(BuildContext context) {
    return SizedBox(
      height: _mediaHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          OfferThumbnail(
            photoUrl: offer.coverPhotoUrl,
            geometry: offer.previewGeojson,
            borderRadius: BorderRadius.zero,
            geometryPadding: _mediaGeometryPadding,
          ),
          if (offer.plotsCountOrOne > 1) ...{
            Positioned(top: _plotsChipOffset, left: _plotsChipOffset, child: _getPlotsCountChip(context)),
          },
          Positioned(
            top: _saveButtonOffset,
            right: _saveButtonOffset,
            child: OfferSaveButton(
              isSaved: offer.isSaved,
              onPressed: onSavePressed,
              backgroundColor: ColorConstants.bgSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPlotsCountChip(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: StyleConstants.edgeInsetsH10V4,
      decoration: const BoxDecoration(
        color: ColorConstants.bgSurface,
        borderRadius: StyleConstants.radius100,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(IconConstants.plots, size: _plotsIconSize, color: ColorConstants.textBrand),
          Text(localizations.offerPlotCount(offer.plotsCountOrOne), style: textTheme.caption12),
        ].withHorizontalElementsSpacing(4),
      ),
    );
  }

  Widget _getDetails(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: StyleConstants.edgeInsets16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getPriceRow(context),
          Text(
            offer.areaLocationLabel(localizations),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyBase16.copyWith(color: ColorConstants.textSecondary),
          ),
          _getFooter(),
        ].withVerticalElementsSpacing(8),
      ),
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
            style: textTheme.headingH3_24,
          ),
        ),
        if (pricePerMeter != null) ...{
          Text(pricePerMeter, style: textTheme.caption12.copyWith(color: ColorConstants.textMuted)),
        },
      ].withHorizontalElementsSpacing(8),
    );
  }

  Widget _getFooter() {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: PlanBadgeWidget(planBadge: OfferPlanBadge.fromOffer(offer)),
          ),
        ),
        OfferUtilitiesWidget(availableUtilities: offer.utilities),
      ].withHorizontalElementsSpacing(8),
    );
  }
}
