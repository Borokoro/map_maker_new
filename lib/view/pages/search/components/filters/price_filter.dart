import 'package:flutter/material.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/custom_types/offer_search_criteria.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_filters_labels_extension.dart';
import 'package:map_maker_new/view/pages/search/components/filters/filter_switch.dart';
import 'package:map_maker_new/view/pages/search/components/filters/range_filter.dart';

class PriceFilter extends StatelessWidget {
  const PriceFilter({
    super.key,
    required this.searchCriteria,
    required this.onChanged,
  });

  final OfferSearchCriteria searchCriteria;
  final void Function(OfferSearchCriteria) onChanged;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        RangeFilter(
          min: searchCriteria.priceMin,
          max: searchCriteria.priceMax,
          rangeMax: OfferSearchCriteria.priceRangeMax,
          step: OfferSearchCriteria.priceRangeStep,
          formatValue: (int value) => formatPrice(localizations, value),
          onChanged: (int? min, int? max) => onChanged(
            searchCriteria.copyWith(priceMin: () => min, priceMax: () => max),
          ),
        ),
        FilterSwitch(
          label: localizations.goodPrice,
          hint: localizations.goodPriceHint,
          value: searchCriteria.goodPrice,
          onChanged: (bool goodPrice) => onChanged(searchCriteria.copyWith(goodPrice: goodPrice)),
        ),
      ].withVerticalElementsSpacing(8),
    );
  }
}
