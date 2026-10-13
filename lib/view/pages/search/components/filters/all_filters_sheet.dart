import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/cubits/search/search_cubit.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/types/custom_types/offer_search_criteria.dart';
import 'package:map_maker_new/types/enum/offer_designation.dart';
import 'package:map_maker_new/types/enum/offer_plan_basis.dart';
import 'package:map_maker_new/types/enum/offer_utility.dart';
import 'package:map_maker_new/utils/offer_filters_labels_extension.dart';
import 'package:map_maker_new/view/pages/search/components/filters/access_filter.dart';
import 'package:map_maker_new/view/pages/search/components/filters/area_filter.dart';
import 'package:map_maker_new/view/pages/search/components/filters/filter_section.dart';
import 'package:map_maker_new/view/pages/search/components/filters/filter_sheet_layout.dart';
import 'package:map_maker_new/view/pages/search/components/filters/location_filter.dart';
import 'package:map_maker_new/view/pages/search/components/filters/multi_choice_filter.dart';
import 'package:map_maker_new/view/pages/search/components/filters/price_filter.dart';

class AllFiltersSheet extends StatefulWidget {
  const AllFiltersSheet({super.key, required this.initialSearchCriteria});

  final OfferSearchCriteria initialSearchCriteria;

  static Future<void> show(BuildContext context, OfferSearchCriteria searchCriteria) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: ColorConstants.bgSurface,
      shape: const RoundedRectangleBorder(borderRadius: StyleConstants.radiusT20),
      builder: (_) => FractionallySizedBox(
        heightFactor: _sheetHeightFactor,
        child: AllFiltersSheet(initialSearchCriteria: searchCriteria),
      ),
    );
  }

  static const double _sheetHeightFactor = 0.9;

  @override
  State<AllFiltersSheet> createState() => _AllFiltersSheetState();
}

class _AllFiltersSheetState extends State<AllFiltersSheet> {
  final SearchCubit _cubit = serviceLocator.get<SearchCubit>();
  late OfferSearchCriteria _searchCriteria = widget.initialSearchCriteria;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return FilterSheetLayout(
      title: localizations.allFilters,
      subtitle: localizations.activeFilters(_searchCriteria.appliedFiltersCount),
      body: _getSections(context),
      clearText: localizations.clearAll,
      applyText: localizations.showOffers,
      onClear: _onClear,
      onApply: _onApply,
    );
  }

  Widget _getSections(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final OfferSearchCriteria criteria = _searchCriteria;

    return Column(
      children: [
        FilterSection(
          title: localizations.location,
          appliedFiltersCount: criteria.hasLocation ? 1 : 0,
          child: LocationFilter(searchCriteria: criteria, onChanged: _onChanged),
        ),
        FilterSection(
          title: localizations.designation,
          appliedFiltersCount: criteria.designations.length,
          child: MultiChoiceFilter<OfferDesignation>(
            options: OfferDesignation.values,
            selectedOptions: criteria.designations,
            labelBuilder: (OfferDesignation designation) => designation.label(localizations),
            onChanged: (List<OfferDesignation> designations) =>
                _onChanged(criteria.copyWith(designations: designations)),
          ),
        ),
        FilterSection(
          title: localizations.price,
          appliedFiltersCount: (criteria.priceMin != null || criteria.priceMax != null ? 1 : 0) +
              (criteria.goodPrice ? 1 : 0),
          child: PriceFilter(searchCriteria: criteria, onChanged: _onChanged),
        ),
        FilterSection(
          title: localizations.areaAndPlots,
          appliedFiltersCount: (criteria.hasArea ? 1 : 0) + (criteria.plotsCount != null ? 1 : 0),
          child: AreaFilter(searchCriteria: criteria, onChanged: _onChanged, withPlotsCount: true),
        ),
        FilterSection(
          title: localizations.planBasis,
          appliedFiltersCount: criteria.planBases.length,
          child: MultiChoiceFilter<OfferPlanBasis>(
            options: OfferPlanBasis.values,
            selectedOptions: criteria.planBases,
            labelBuilder: (OfferPlanBasis planBasis) => planBasis.label(localizations),
            onChanged: (List<OfferPlanBasis> planBases) => _onChanged(criteria.copyWith(planBases: planBases)),
          ),
        ),
        FilterSection(
          title: localizations.media,
          appliedFiltersCount: criteria.utilities.length,
          child: MultiChoiceFilter<OfferUtility>(
            options: OfferUtility.values,
            selectedOptions: criteria.utilities,
            labelBuilder: (OfferUtility utility) => utility.label(localizations),
            onChanged: (List<OfferUtility> utilities) => _onChanged(criteria.copyWith(utilities: utilities)),
          ),
        ),
        FilterSection(
          title: localizations.access,
          appliedFiltersCount: (criteria.roadAccess ? 1 : 0) + (criteria.cityDistanceMaxKm != null ? 1 : 0),
          child: AccessFilter(searchCriteria: criteria, onChanged: _onChanged),
        ),
      ],
    );
  }

  void _onChanged(OfferSearchCriteria searchCriteria) {
    setState(() => _searchCriteria = searchCriteria);
  }

  void _onClear() {
    _cubit.onClearFilters();
    Navigator.of(context).pop();
  }

  void _onApply() {
    _cubit.onSearchCriteriaChanged(_searchCriteria);
    Navigator.of(context).pop();
  }
}
