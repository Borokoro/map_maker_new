import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/cubits/search/search_cubit.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/types/custom_types/offer_search_criteria.dart';
import 'package:map_maker_new/types/enum/filter_category.dart';
import 'package:map_maker_new/types/enum/offer_designation.dart';
import 'package:map_maker_new/types/enum/offer_utility.dart';
import 'package:map_maker_new/utils/offer_filters_labels_extension.dart';
import 'package:map_maker_new/view/pages/search/components/filters/area_filter.dart';
import 'package:map_maker_new/view/pages/search/components/filters/filter_sheet_layout.dart';
import 'package:map_maker_new/view/pages/search/components/filters/location_filter.dart';
import 'package:map_maker_new/view/pages/search/components/filters/multi_choice_filter.dart';
import 'package:map_maker_new/view/pages/search/components/filters/price_filter.dart';

class QuickFilterSheet extends StatefulWidget {
  const QuickFilterSheet({
    super.key,
    required this.filterCategory,
    required this.initialSearchCriteria,
  });

  final FilterCategory filterCategory;
  final OfferSearchCriteria initialSearchCriteria;

  static Future<void> show(BuildContext context, FilterCategory filterCategory, OfferSearchCriteria searchCriteria) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: ColorConstants.bgSurface,
      shape: const RoundedRectangleBorder(borderRadius: StyleConstants.radiusT20),
      builder: (_) => QuickFilterSheet(
        filterCategory: filterCategory,
        initialSearchCriteria: searchCriteria,
      ),
    );
  }

  @override
  State<QuickFilterSheet> createState() => _QuickFilterSheetState();
}

class _QuickFilterSheetState extends State<QuickFilterSheet> {
  final SearchCubit _cubit = serviceLocator.get<SearchCubit>();
  late OfferSearchCriteria _searchCriteria = widget.initialSearchCriteria;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return FilterSheetLayout(
      title: widget.filterCategory.title(localizations),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: _getFilterBody(),
      ),
      clearText: localizations.clear,
      applyText: localizations.apply,
      onClear: _onClear,
      onApply: _onApply,
    );
  }

  Widget _getFilterBody() {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    switch (widget.filterCategory) {
      case FilterCategory.location:
        return LocationFilter(searchCriteria: _searchCriteria, onChanged: _onChanged);
      case FilterCategory.price:
        return PriceFilter(searchCriteria: _searchCriteria, onChanged: _onChanged);
      case FilterCategory.area:
        return AreaFilter(searchCriteria: _searchCriteria, onChanged: _onChanged);
      case FilterCategory.designation:
        return MultiChoiceFilter<OfferDesignation>(
          options: OfferDesignation.values,
          selectedOptions: _searchCriteria.designations,
          labelBuilder: (OfferDesignation designation) => designation.label(localizations),
          onChanged: (List<OfferDesignation> designations) =>
              _onChanged(_searchCriteria.copyWith(designations: designations)),
        );
      case FilterCategory.media:
        return MultiChoiceFilter<OfferUtility>(
          options: OfferUtility.values,
          selectedOptions: _searchCriteria.utilities,
          labelBuilder: (OfferUtility utility) => utility.label(localizations),
          onChanged: (List<OfferUtility> utilities) => _onChanged(_searchCriteria.copyWith(utilities: utilities)),
        );
    }
  }

  void _onChanged(OfferSearchCriteria searchCriteria) {
    setState(() => _searchCriteria = searchCriteria);
  }

  void _onClear() {
    _cubit.onClearFilters(filterCategory: widget.filterCategory);
    Navigator.of(context).pop();
  }

  void _onApply() {
    _cubit.onSearchCriteriaChanged(_searchCriteria);
    Navigator.of(context).pop();
  }
}
