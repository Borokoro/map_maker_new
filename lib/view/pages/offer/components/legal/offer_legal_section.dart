import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/enum/offer_legal_row.dart';
import 'package:map_maker_new/types/enum/plan_badge_tone.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/types/models/offer_plot.dart';
import 'package:map_maker_new/types/models/plot_document.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_details_labels_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_section_header.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_tone_badge.dart';
import 'package:map_maker_new/view/pages/offer/components/legal/offer_document_tile.dart';
import 'package:map_maker_new/view/shared_components/widgets/guarded_tab.dart';

class OfferLegalSection extends StatelessWidget {
  const OfferLegalSection({super.key, required this.offerDetails, required this.onDownloadDocumentPressed});

  final OfferDetails offerDetails;
  final ValueChanged<PlotDocument> onDownloadDocumentPressed;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final bool hasDocuments = offerDetails.plots.any((OfferPlot plot) => plot.documents.isNotEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OfferSectionHeader(overline: localizations.offerLegalOverline, title: localizations.offerLegalTitle),
        ...OfferLegalRow.values.map((OfferLegalRow row) => _getRow(context, row)),
        if (hasDocuments) ...{
          _getDocuments(context),
        },
      ].withVerticalElementsSpacing(12),
    );
  }

  Widget _getRow(BuildContext context, OfferLegalRow row) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(row.label(localizations), style: textTheme.caption12.copyWith(color: ColorConstants.textMuted)),
              Text(row.value(localizations, offerDetails), style: textTheme.bodySmall14),
            ].withVerticalElementsSpacing(2),
          ),
        ),
        OfferToneBadge(text: localizations.offerSourceOwner, tone: PlanBadgeTone.neutral),
      ].withHorizontalElementsSpacing(8),
    );
  }

  Widget _getDocuments(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle hintStyle = textTheme.bodySmall14.copyWith(
      color: ColorConstants.textMuted,
      fontWeight: FontWeight.w400,
    );
    final bool hasManyPlots = offerDetails.plots.length > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(localizations.offerDocumentsTitle, style: textTheme.bodyLarge18.copyWith(fontWeight: FontWeight.w600)),
        GuardedTab(
          childWhenUnauthenticated: Text(localizations.offerDocumentsHint, style: hintStyle),
          childWhenAuthenticated: Text(localizations.offerDocumentsHintSignedIn, style: hintStyle),
        ),
        for (final OfferPlot plot in offerDetails.plots)
          for (final PlotDocument document in plot.documents)
            OfferDocumentTile(
              document: document,
              plotNumber: hasManyPlots ? plot.plotNumber : null,
              onDownloadPressed: () => onDownloadDocumentPressed(document),
            ),
      ].withVerticalElementsSpacing(8),
    );
  }
}
