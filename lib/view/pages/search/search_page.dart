import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/cubits/search/search_cubit.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/types/custom_types/offer_search_criteria.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/view/pages/search/components/filter_button.dart';
import 'package:map_maker_new/view/pages/search/components/quick_filters_horizontal_scrollable.dart';
import 'package:map_maker_new/view/pages/search/components/search_page_map.dart';
import 'package:map_maker_new/view/pages/search/components/searchbar/searchbar_wrapper.dart';
import 'package:map_maker_new/view/shared_components/widgets/universal_app_bar_widget.dart';

@RoutePage(name: "SearchRoute")
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchCubit _cubit = serviceLocator.get<SearchCubit>();

  @override
  void initState() {
    super.initState();
    if (_cubit.state is SearchInitial) {
      _cubit.fetchPublicOffers();
    }
  }

  static const double _searchControlsTopMargin = 12;
  static const double _searchControlsSpacing = 8;
  static const double _searchControlsHeight = _searchControlsTopMargin +
      FilterButton.size +
      _searchControlsSpacing +
      QuickFiltersHorizontalScrollable.quickFiltersHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniversalAppBarWidget(),
      body: SafeArea(
        child: BlocBuilder<SearchCubit, SearchState>(
          bloc: _cubit,
          builder: _mapStateToWidget,
        ),
      ),
    );
  }

  Widget _mapStateToWidget(BuildContext context, SearchState searchState) {
    if (searchState is SearchLoading || searchState is SearchInitial) {
      return _getSearchLoadingBody();
    } else if (searchState is SearchLoaded) {
      return _getSearchLoadedBody(context, searchState);
    } else {
      return _getSearchErrorBody(context, searchState as SearchError);
    }
  }

  Widget _getSearchLoadingBody() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _getSearchLoadedBody(BuildContext context, SearchLoaded state) {
    return Stack(
      children: [
        SearchPageMap(
          offers: state.publicOffers.results,
          onOfferTap: _cubit.onOfferTapped,
          onMapTap: _cubit.unselectOffer,
          searchedLocation: _getSearchedLocation(state.searchCriteria),
          topPadding: _searchControlsHeight,
        ),
        _getSearchControls(
          state.searchCriteria,
          isLoading: state is SearchFiltersLoading,
        ),
      ],
    );
  }

  Widget _getSearchErrorBody(BuildContext context, SearchError state) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        _getSearchControls(state.searchCriteria),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(localizations.offersLoadingError, style: textTheme.bodyLarge),
                TextButton(
                  onPressed: _cubit.fetchPublicOffers,
                  child: Text(localizations.retry),
                ),
              ].withVerticalElementsSpacing(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getSearchControls(OfferSearchCriteria searchCriteria, {bool isLoading = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: StyleConstants.edgeInsetsH16T12,
          child: SearchbarWrapper(searchCriteria: searchCriteria),
        ),
        QuickFiltersHorizontalScrollable(searchCriteria: searchCriteria),
        if (isLoading)
          const Padding(
            padding: StyleConstants.edgeInsetsH16,
            child: LinearProgressIndicator(
              color: ColorConstants.bgBrand,
              backgroundColor: ColorConstants.bgBrandSoft,
            ),
          ),
      ].withVerticalElementsSpacing(_searchControlsSpacing),
    );
  }

  String? _getSearchedLocation(OfferSearchCriteria searchCriteria) {
    if (!searchCriteria.hasLocation && searchCriteria.query == null) return null;
    return [
      searchCriteria.query,
      searchCriteria.voivodeship,
      searchCriteria.county,
      searchCriteria.commune,
    ].join("|");
  }
}
