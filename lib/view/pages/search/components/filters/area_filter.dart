import 'package:flutter/material.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/custom_types/offer_search_criteria.dart';
import 'package:map_maker_new/types/enum/offer_plots_count.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_filters_labels_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/pages/search/components/filters/filter_choice_chip.dart';
import 'package:map_maker_new/view/pages/search/components/filters/range_filter.dart';
import 'package:map_maker_new/utils/offer_formatters.dart';

class AreaFilter extends StatelessWidget {
  const AreaFilter({
    super.key,
    required this.searchCriteria,
    required this.onChanged,
    this.withPlotsCount = false,
  });

  final OfferSearchCriteria searchCriteria;
  final void Function(OfferSearchCriteria) onChanged;
  final bool withPlotsCount;

  static const List<OfferPlotsCount?> _plotsCountOptions = [null, ...OfferPlotsCount.values];

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RangeFilter(
          min: searchCriteria.areaMin,
          max: searchCriteria.areaMax,
          rangeMax: OfferSearchCriteria.areaRangeMax,
          step: OfferSearchCriteria.areaRangeStep,
          formatValue: (int value) => OfferFormatters.formatArea(localizations, value),
          onChanged: (int? min, int? max) => onChanged(
            searchCriteria.copyWith(areaMin: () => min, areaMax: () => max),
          ),
        ),
        if (withPlotsCount) ...{
          _getPlotsCount(context),
        },
      ].withVerticalElementsSpacing(16),
    );
  }

  Widget _getPlotsCount(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localizations.plots, style: textTheme.bodySmall14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final OfferPlotsCount? plotsCount in _plotsCountOptions)
              FilterChoiceChip(
                label: plotsCount.label(localizations),
                isSelected: searchCriteria.plotsCount == plotsCount,
                onTap: () => onChanged(searchCriteria.copyWith(plotsCount: () => plotsCount)),
              ),
          ],
        ),
      ].withVerticalElementsSpacing(8),
    );
  }
}
