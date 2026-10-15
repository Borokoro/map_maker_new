import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/models/valuation_band.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/utils/offer_formatters.dart';

class ValuationRangeBar extends StatelessWidget {
  const ValuationRangeBar({super.key, required this.band, this.markerValue});

  final ValuationBand band;
  final double? markerValue;

  static const double _barHeight = 24;
  static const double _trackHeight = 8;
  static const double _markerWidth = 3;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle labelStyle = textTheme.caption12.copyWith(color: ColorConstants.textMuted);
    final double? marker = markerValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: _barHeight,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) => _getBar(constraints.maxWidth),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(OfferFormatters.formatPrice(localizations, band.low.round()), style: labelStyle)),
            Flexible(
              child: Text(OfferFormatters.formatPrice(localizations, band.high.round()), style: labelStyle, textAlign: TextAlign.end),
            ),
          ],
        ),
        if (marker != null) ...{
          Text(
            localizations.offerValuationMarker(OfferFormatters.formatPrice(localizations, marker.round())),
            style: textTheme.caption12.copyWith(color: ColorConstants.textPrimary),
          ),
        },
      ].withVerticalElementsSpacing(4),
    );
  }

  Widget _getBar(double width) {
    final double? marker = markerValue;
    final double minValue = marker != null ? math.min(band.low, marker) : band.low;
    final double maxValue = marker != null ? math.max(band.high, marker) : band.high;
    final double range = maxValue - minValue;
    double getPosition(double value) => range <= 0 ? width / 2 : ((value - minValue) / range * width).clamp(0, width);
    final double likelyStart = getPosition(band.likelyLow);
    final double likelyEnd = getPosition(band.likelyHigh);
    const double trackTop = (_barHeight - _trackHeight) / 2;

    return Stack(
      children: [
        const Positioned(
          left: 0,
          right: 0,
          top: trackTop,
          height: _trackHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(color: ColorConstants.bgSurfaceAlt, borderRadius: StyleConstants.radius100),
          ),
        ),
        Positioned(
          left: likelyStart,
          width: math.max(likelyEnd - likelyStart, _trackHeight),
          top: trackTop,
          height: _trackHeight,
          child: const DecoratedBox(
            decoration: BoxDecoration(color: ColorConstants.bgBrand, borderRadius: StyleConstants.radius100),
          ),
        ),
        if (marker != null) ...{
          Positioned(
            left: (getPosition(marker) - _markerWidth / 2).clamp(0, width - _markerWidth),
            width: _markerWidth,
            top: 0,
            bottom: 0,
            child: const DecoratedBox(
              decoration: BoxDecoration(color: ColorConstants.textPrimary, borderRadius: StyleConstants.radius100),
            ),
          ),
        },
      ],
    );
  }
}
