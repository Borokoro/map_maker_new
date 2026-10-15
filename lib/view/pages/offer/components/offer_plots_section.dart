import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/custom_types/offer_plan_badge.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/types/models/offer_plot.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_details_extension.dart';
import 'package:map_maker_new/utils/offer_details_labels_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_section_header.dart';
import 'package:map_maker_new/view/shared_components/widgets/plan_badge_widget.dart';
import 'package:map_maker_new/view/shared_components/widgets/text_link_button.dart';
import 'package:map_maker_new/utils/offer_formatters.dart';

class OfferPlotsSection extends StatelessWidget {
  const OfferPlotsSection({super.key, required this.offerDetails, required this.onOpenReportPressed});

  final OfferDetails offerDetails;
  final ValueChanged<OfferPlot> onOpenReportPressed;

  static const double _indexSize = 28;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final List<OfferPlot> plots = offerDetails.plots;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OfferSectionHeader(overline: localizations.offerPlotsOverline, title: offerDetails.plotsTitle(localizations)),
        ...List.generate(plots.length, (int index) => _getPlotRow(context, plots[index], index)),
      ].withVerticalElementsSpacing(12),
    );
  }

  Widget _getPlotRow(BuildContext context, OfferPlot plot, int index) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: StyleConstants.edgeInsets12,
      decoration: BoxDecoration(
        borderRadius: StyleConstants.radius12,
        border: Border.all(color: ColorConstants.borderDefault),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: _indexSize,
            height: _indexSize,
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: ColorConstants.bgBrandSoft, shape: BoxShape.circle),
            child: Text((index + 1).toString(), style: textTheme.caption12.copyWith(color: ColorConstants.textBrand)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plot.plotNumber, style: textTheme.bodySmall14),
                Text(_getPlotMeta(localizations, plot), style: textTheme.caption12.copyWith(color: ColorConstants.textMuted)),
                PlanBadgeWidget(planBadge: OfferPlanBadge.fromPlot(plot), withHint: true, isMultiline: true),
                if (plot.hasReport) ...{
                  TextLinkButton(text: localizations.offerPlotsOpenReport, onPressed: () => onOpenReportPressed(plot)),
                } else ...{
                  Text(
                    localizations.offerPlotsReportPending,
                    style: textTheme.caption12.copyWith(color: ColorConstants.textMuted),
                  ),
                },
              ].withVerticalElementsSpacing(6),
            ),
          ),
        ].withHorizontalElementsSpacing(12),
      ),
    );
  }

  String _getPlotMeta(AppLocalizations localizations, OfferPlot plot) {
    final List<String> parts = [];
    parts.add(OfferFormatters.formatAreaValue(localizations, plot.area));
    if (offerDetails.planSymbols.isNotEmpty) {
      parts.add(offerDetails.planSymbols.join(", "));
    }
    return parts.join(localizations.textSeparator);
  }
}
