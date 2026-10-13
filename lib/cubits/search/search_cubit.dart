import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/services/public_offers_service.dart';
import 'package:map_maker_new/types/custom_types/offer_search_criteria.dart';
import 'package:map_maker_new/types/enum/filter_category.dart';
import 'package:map_maker_new/types/models/offer_locations.dart';
import 'package:map_maker_new/types/models/public_offers.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._publicOffersService) : super(SearchInitial());
  final PublicOffersService _publicOffersService;

  OfferSearchCriteria get searchCriteria {
    final SearchState currentState = state;
    if (currentState is SearchLoading) return currentState.searchCriteria;
    if (currentState is SearchLoaded) return currentState.searchCriteria;
    if (currentState is SearchError) return currentState.searchCriteria;
    return const OfferSearchCriteria();
  }

  Future<void> fetchPublicOffers() async {
    final OfferSearchCriteria criteria = searchCriteria;
    emit(SearchLoading(searchCriteria: criteria));
    await _search(criteria);
  }

  Future<void> onSearchCriteriaChanged(OfferSearchCriteria criteria) async {
    final SearchState currentState = state;
    if (currentState is SearchLoaded) {
      emit(SearchFiltersLoading(
        publicOffers: currentState.publicOffers,
        searchCriteria: criteria,
      ));
    } else {
      emit(SearchLoading(searchCriteria: criteria));
    }
    await _search(criteria);
  }

  Future<void> onSearchSubmitted(String query) {
    final String trimmedQuery = query.trim();
    return onSearchCriteriaChanged(
      searchCriteria.copyWith(query: () => trimmedQuery.isEmpty ? null : trimmedQuery),
    );
  }

  Future<void> onClearFilters({FilterCategory? filterCategory}) {
    final OfferSearchCriteria criteria = filterCategory == null
        ? searchCriteria.cleared()
        : searchCriteria.clearedFilterCategory(filterCategory);
    return onSearchCriteriaChanged(criteria);
  }

  Future<OfferLocations> getLocations({String? voivodeship, String? county}) {
    return _publicOffersService.getLocations(voivodeship: voivodeship, county: county);
  }

  void onOfferTapped(String offerId) {
    final SearchState currentState = state;
    if (currentState is SearchLoaded && currentState is! SearchFiltersLoading) {
      emit(currentState.copyWith(selectedOfferId: () => offerId));
    }
  }

  void unselectOffer() {
    final SearchState currentState = state;
    if (currentState is SearchLoaded &&
        currentState is! SearchFiltersLoading &&
        currentState.selectedOfferId != null) {
      emit(currentState.copyWith(selectedOfferId: () => null));
    }
  }

  Future<void> _search(OfferSearchCriteria criteria) async {
    try{
      final PublicOffers publicOffers = await _publicOffersService
          .getAllPublicOffers(searchCriteria: criteria);
      if (_isOutdated(criteria)) return;
      emit(SearchLoaded(publicOffers: publicOffers, searchCriteria: criteria));
    }
    on DioException catch(e) {
      if (_isOutdated(criteria)) return;
      emit(SearchError(exception: e, searchCriteria: criteria));
    }
    catch(_) {
      if (_isOutdated(criteria)) return;
      emit(SearchError(searchCriteria: criteria));
    }
  }

  bool _isOutdated(OfferSearchCriteria criteria) => searchCriteria != criteria;
}
