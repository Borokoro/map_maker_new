import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/enum/price_verdict.dart';
import 'package:map_maker_new/types/models/offer_valuation.dart';
import 'package:map_maker_new/types/models/valuation_band.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_details_labels_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_note.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_tone_badge.dart';
import 'package:map_maker_new/view/pages/offer/components/valuation/valuation_range_bar.dart';
import 'package:map_maker_new/utils/offer_formatters.dart';

class OfferValuationCard extends StatelessWidget {
  const OfferValuationCard({super.key, required this.valuation, required this.price, this.isCompact = false});

  final OfferValuation valuation;
  final double? price;
  final bool isCompact;

  static const double _iconSize = 18;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ValuationBand total = valuation.total;
    final String meta = _getMeta(localizations);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isCompact) ...{
          _getHeader(context),
        },
        if (!isCompact) ...{
          Text(
            localizations.offerValuationEstimate(OfferFormatters.formatPriceRange(localizations, total.likelyLow, total.likelyHigh)),
            style: textTheme.bodyLarge18.copyWith(fontWeight: FontWeight.w600),
          ),
        },
        if (meta.isNotEmpty) ...{
          Text(
            meta,
            style: textTheme.bodySmall14.copyWith(color: ColorConstants.textSecondary, fontWeight: FontWeight.w400),
          ),
        },
        ValuationRangeBar(band: total, markerValue: price),
        OfferNote(text: localizations.offerValuationNote),
      ].withVerticalElementsSpacing(10),
    );
  }

  Widget _getHeader(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final PriceVerdict? verdict = valuation.priceVerdict;

    return Row(
      children: [
        const Icon(IconConstants.valuation, size: _iconSize, color: ColorConstants.textBrand),
        Expanded(
          child: Text(
            localizations.offerValuationTitle,
            style: textTheme.bodyLarge18.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        if (verdict != null) ...{
          OfferToneBadge(text: verdict.label(localizations), tone: verdict.tone),
        },
      ].withHorizontalElementsSpacing(8),
    );
  }

  String _getMeta(AppLocalizations localizations) {
    final ValuationBand? perM2 = valuation.perM2;
    final PriceVerdict? verdict = valuation.priceVerdict;
    final List<String> parts = [];
    if (perM2 != null) {
      parts.add(
        localizations.offerValuationPerMeter(OfferFormatters.formatPricePerMeterRange(localizations, perM2.likelyLow, perM2.likelyHigh)),
      );
    }
    if (verdict != null) {
      parts.add(verdict.positionLabel(localizations));
    }
    return parts.join(" ");
  }
}
