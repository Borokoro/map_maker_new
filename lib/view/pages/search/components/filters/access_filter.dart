import 'package:flutter/material.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/custom_types/offer_search_criteria.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/pages/search/components/filters/filter_choice_chip.dart';
import 'package:map_maker_new/view/pages/search/components/filters/filter_switch.dart';

class AccessFilter extends StatelessWidget {
  const AccessFilter({
    super.key,
    required this.searchCriteria,
    required this.onChanged,
  });

  final OfferSearchCriteria searchCriteria;
  final void Function(OfferSearchCriteria) onChanged;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterSwitch(
          label: localizations.roadAccess,
          hint: localizations.roadAccessHint,
          value: searchCriteria.roadAccess,
          onChanged: (bool roadAccess) => onChanged(searchCriteria.copyWith(roadAccess: roadAccess)),
        ),
        Text(localizations.cityDistance, style: textTheme.bodySmall14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final int distanceKm in OfferSearchCriteria.cityDistancesKm)
              FilterChoiceChip(
                label: localizations.cityDistanceKm(distanceKm),
                isSelected: searchCriteria.cityDistanceMaxKm == distanceKm,
                onTap: () => _onDistanceTapped(distanceKm),
              ),
          ],
        ),
      ].withVerticalElementsSpacing(8),
    );
  }

  void _onDistanceTapped(int distanceKm) {
    final bool isSelected = searchCriteria.cityDistanceMaxKm == distanceKm;
    onChanged(searchCriteria.copyWith(cityDistanceMaxKm: () => isSelected ? null : distanceKm));
  }
}
