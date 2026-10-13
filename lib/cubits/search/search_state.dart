part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
  const SearchInitial();

  @override
  List<Object?> get props => [];
}

class SearchLoading extends SearchState {
  final OfferSearchCriteria searchCriteria;

  const SearchLoading({required this.searchCriteria});

  @override
  List<Object?> get props => [searchCriteria];
}

class SearchLoaded extends SearchState {
  final PublicOffers publicOffers;
  final OfferSearchCriteria searchCriteria;
  final String? selectedOfferId;

  const SearchLoaded({
    required this.publicOffers,
    required this.searchCriteria,
    this.selectedOfferId,
  });

  SearchLoaded copyWith({
    PublicOffers? publicOffers,
    OfferSearchCriteria? searchCriteria,
    String? Function()? selectedOfferId,
  }) {
    return SearchLoaded(
      publicOffers: publicOffers ?? this.publicOffers,
      searchCriteria: searchCriteria ?? this.searchCriteria,
      selectedOfferId: selectedOfferId != null
          ? selectedOfferId()
          : this.selectedOfferId,
    );
  }

  @override
  List<Object?> get props => [publicOffers, searchCriteria, selectedOfferId];
}

class SearchFiltersLoading extends SearchLoaded {
  const SearchFiltersLoading({
    required super.publicOffers,
    required super.searchCriteria,
  });
}

class SearchError extends SearchState {
  final DioException? exception;
  final OfferSearchCriteria searchCriteria;

  const SearchError({this.exception, required this.searchCriteria});

  @override
  List<Object?> get props => [exception, searchCriteria];
}
