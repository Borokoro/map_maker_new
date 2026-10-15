import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/enum/plan_badge_tone.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/types/models/offer_plot.dart';
import 'package:map_maker_new/types/models/offer_valuation.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_details_extension.dart';
import 'package:map_maker_new/utils/offer_labels_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_card_container.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_note.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_tone_badge.dart';
import 'package:map_maker_new/view/pages/offer/components/valuation/offer_valuation_card.dart';
import 'package:map_maker_new/utils/offer_formatters.dart';

class OfferPriceSection extends StatefulWidget {
  const OfferPriceSection({super.key, required this.offerDetails});

  final OfferDetails offerDetails;

  @override
  State<OfferPriceSection> createState() => _OfferPriceSectionState();
}

class _OfferPriceSectionState extends State<OfferPriceSection> {
  static const double _iconSize = 18;
  static const double _chevronSize = 18;

  bool _isValuationVisible = false;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final OfferDetails offerDetails = widget.offerDetails;
    final double? price = offerDetails.offer.price;
    final OfferValuation? valuation = offerDetails.valuation;
    final TextStyle metaStyle = textTheme.bodySmall14.copyWith(
      color: ColorConstants.textMuted,
      fontWeight: FontWeight.w400,
    );

    return OfferCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getHeader(context),
          if (price != null && valuation != null) ...{
            _getValuationToggle(context),
          } else ...{
            _getPrice(context),
          },
          if (price == null && offerDetails.offer.estimate != null) ...{
            Text(localizations.offerPriceEstimateHint, style: metaStyle),
          },
          if (price != null) ...{
            Text(
              localizations.offerPricePerMeterWithArea(
                offerDetails.offer.pricePerMeterLabel(localizations) ?? localizations.offerEmptyValue,
                OfferFormatters.formatAreaValue(localizations, offerDetails.offer.totalArea),
              ),
              style: metaStyle,
            ),
          },
          if (offerDetails.separatelyPricedPlots.isNotEmpty) ...{
            _getSeparatePrices(context),
          },
          if (valuation != null && price != null && _isValuationVisible) ...{
            OfferValuationCard(valuation: valuation, price: price),
          },
          if (valuation != null && price == null) ...{
            OfferValuationCard(valuation: valuation, price: null, isCompact: true),
          },
          if (price != null) ...{
            OfferNote(text: localizations.offerPriceNote),
          },
        ].withVerticalElementsSpacing(12),
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isNegotiable = widget.offerDetails.offer.priceNegotiable;

    return Row(
      children: [
        const Icon(IconConstants.price, size: _iconSize, color: ColorConstants.textBrand),
        Expanded(
          child: Text(
            localizations.offerPriceTitle,
            style: textTheme.bodyLarge18.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        if (widget.offerDetails.offer.price != null) ...{
          OfferToneBadge(
            text: isNegotiable ? localizations.offerPriceNegotiable : localizations.offerPriceFixed,
            tone: isNegotiable ? PlanBadgeTone.success : PlanBadgeTone.neutral,
          ),
        },
      ].withHorizontalElementsSpacing(8),
    );
  }

  Widget _getPrice(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Text(widget.offerDetails.offer.priceLabel(localizations), style: textTheme.price28);
  }

  Widget _getValuationToggle(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => setState(() => _isValuationVisible = !_isValuationVisible),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getPrice(context),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  _isValuationVisible ? localizations.offerHideValuation : localizations.offerShowValuation,
                  style: textTheme.bodySmall14.copyWith(color: ColorConstants.textBrand),
                ),
              ),
              Icon(
                _isValuationVisible ? IconConstants.chevronUp : IconConstants.chevronDown,
                size: _chevronSize,
                color: ColorConstants.textBrand,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getSeparatePrices(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle rowStyle = textTheme.bodySmall14.copyWith(fontWeight: FontWeight.w400);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(localizations.offerPriceSeparately, style: textTheme.bodySmall14),
        ...widget.offerDetails.separatelyPricedPlots.map(
          (OfferPlot plot) => Row(
            children: [
              Expanded(child: Text(plot.plotNumber, style: rowStyle)),
              Text(OfferFormatters.formatFullPrice(localizations, plot.separatePrice ?? 0), style: textTheme.bodySmall14),
            ].withHorizontalElementsSpacing(8),
          ),
        ),
      ].withVerticalElementsSpacing(6),
    );
  }
}
