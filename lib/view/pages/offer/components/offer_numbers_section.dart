import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/enum/offer_number_tile.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_details_labels_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_section_header.dart';

class OfferNumbersSection extends StatelessWidget {
  const OfferNumbersSection({super.key, required this.offerDetails});

  final OfferDetails offerDetails;

  static const double _tilesSpacing = 12;
  static const int _tilesPerRow = 2;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OfferSectionHeader(overline: localizations.offerNumbersOverline, title: localizations.offerNumbersTitle),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double tileWidth = (constraints.maxWidth - _tilesSpacing * (_tilesPerRow - 1)) / _tilesPerRow;
            return Wrap(
              spacing: _tilesSpacing,
              runSpacing: _tilesSpacing,
              children: OfferNumberTile.values
                  .map((OfferNumberTile tile) => _getTile(context, tile, tileWidth))
                  .toList(),
            );
          },
        ),
      ].withVerticalElementsSpacing(16),
    );
  }

  Widget _getTile(BuildContext context, OfferNumberTile tile, double width) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      width: width,
      padding: StyleConstants.edgeInsets12,
      decoration: const BoxDecoration(color: ColorConstants.bgSurfaceAlt, borderRadius: StyleConstants.radius12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tile.value(localizations, offerDetails), style: textTheme.headingH4_20),
          Text(tile.label(localizations, offerDetails), style: textTheme.caption12.copyWith(color: ColorConstants.textMuted)),
        ].withVerticalElementsSpacing(4),
      ),
    );
  }
}
