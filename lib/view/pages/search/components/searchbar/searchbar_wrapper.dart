import 'package:flutter/material.dart';
import 'package:map_maker_new/cubits/search/search_cubit.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/types/custom_types/offer_search_criteria.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/view/pages/search/components/filter_button.dart';
import 'package:map_maker_new/view/pages/search/components/searchbar/searchbar_widget.dart';

class SearchbarWrapper extends StatelessWidget {
  SearchbarWrapper({
    super.key,
    required this.searchCriteria,
  });

  final OfferSearchCriteria searchCriteria;
  final SearchCubit _cubit = serviceLocator.get<SearchCubit>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchBarWidget(
            query: searchCriteria.query,
            onSearchSubmitted: _cubit.onSearchSubmitted,
          ),
        ),
        FilterButton(searchCriteria: searchCriteria),
      ].withHorizontalElementsSpacing(8),
    );
  }
}
