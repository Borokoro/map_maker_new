import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/custom_types/offer_search_criteria.dart';
import 'package:map_maker_new/types/enum/filter_category.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_filters_labels_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/pages/search/components/filters/quick_filter_sheet.dart';

class QuickFiltersHorizontalScrollable extends StatelessWidget {
  const QuickFiltersHorizontalScrollable({
    super.key,
    required this.searchCriteria,
    this.isDisabled = false,
  });

  final OfferSearchCriteria searchCriteria;
  final bool isDisabled;

  static const double quickFiltersHeight = 40;
  static const double _chevronSize = 18;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: quickFiltersHeight,
      padding: StyleConstants.edgeInsetsH16,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final FilterCategory filterCategory in FilterCategory.values)
              _getFilterChip(context, filterCategory),
          ].withHorizontalElementsSpacing(8),
        ),
      ),
    );
  }

  Widget _getFilterChip(BuildContext context, FilterCategory filterCategory) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isSelected = searchCriteria.isFilterCategoryApplied(filterCategory);
    final Color contentColor = isSelected ? ColorConstants.textBrand : ColorConstants.textPrimary;

    return Material(
      color: isSelected ? ColorConstants.bgBrandSoft : ColorConstants.bgSurface,
      shape: RoundedRectangleBorder(
        borderRadius: StyleConstants.radius100,
        side: BorderSide(color: isSelected ? ColorConstants.borderBrand : ColorConstants.borderDefault),
      ),
      child: InkWell(
        borderRadius: StyleConstants.radius100,
        onTap: isDisabled ? null : () => QuickFilterSheet.show(context, filterCategory, searchCriteria),
        child: Padding(
          padding: StyleConstants.edgeInsetsH16,
          child: Row(
            children: [
              Text(
                filterCategory.chipLabel(localizations, searchCriteria),
                style: textTheme.bodySmall14.copyWith(color: contentColor),
              ),
              Icon(IconConstants.chevronDown, color: contentColor, size: _chevronSize),
            ].withHorizontalElementsSpacing(4),
          ),
        ),
      ),
    );
  }
}
