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
  const SearchLoading();

  @override
  List<Object?> get props => [];
}

class SearchLoaded extends SearchState {
  final PublicOffers publicOffers;

  const SearchLoaded({required this.publicOffers});

  @override
  List<Object?> get props => [publicOffers];
}

class SearchError extends SearchState {
  final DioException? exception;

  const SearchError({this.exception});

  @override
  List<Object?> get props => [exception];
}
