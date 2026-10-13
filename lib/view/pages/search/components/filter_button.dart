import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/custom_types/offer_search_criteria.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/pages/search/components/filters/all_filters_sheet.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    this.searchCriteria = const OfferSearchCriteria(),
  });

  final OfferSearchCriteria searchCriteria;

  static const double size = 48;
  static const double _iconSize = 22;
  static const double _highlighterSize = 18;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _getFilterButton(context),
          if (searchCriteria.isAnyFiltersApplied)
            Positioned(
              top: -4,
              right: -4,
              child: _getFilterHighlighter(context),
            ),
        ],
      ),
    );
  }

  Widget _getFilterButton(BuildContext context) {
    return Material(
      color: ColorConstants.bgSurface,
      shape: const CircleBorder(),
      elevation: 0,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => AllFiltersSheet.show(context, searchCriteria),
        child: Ink(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: StyleConstants.mapElementShadow,
            color: ColorConstants.bgSurface,
          ),
          child: Icon(
            IconConstants.filter,
            semanticLabel: AppLocalizations.of(context)!.allFilters,
            color: ColorConstants.textPrimary,
            size: _iconSize,
          ),
        ),
      ),
    );
  }

  Widget _getFilterHighlighter(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      constraints: const BoxConstraints(minWidth: _highlighterSize),
      height: _highlighterSize,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: const BoxDecoration(
        color: ColorConstants.bgBrand,
        borderRadius: StyleConstants.radius100,
      ),
      child: Center(
        child: Text(
          searchCriteria.appliedFiltersCount.toString(),
          style: textTheme.caption12.copyWith(color: ColorConstants.textOnBrand),
        ),
      ),
    );
  }
}
