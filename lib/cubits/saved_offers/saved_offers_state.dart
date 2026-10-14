part of 'saved_offers_cubit.dart';

abstract class SavedOffersState extends Equatable {
  const SavedOffersState();

  @override
  List<Object?> get props => [];
}

class SavedOffersLoading extends SavedOffersState {
  const SavedOffersLoading();
}

class SavedOffersLoaded extends SavedOffersState implements PaginatedStateInfinityScroll<Offer> {
  @override
  final List<Offer> items;
  @override
  final int? nextPage;
  @override
  final int itemsCount;
  @override
  final bool isLoadingMore;
  @override
  final bool hasLoadMoreError;

  const SavedOffersLoaded({
    required this.items,
    required this.itemsCount,
    this.nextPage,
    this.isLoadingMore = false,
    this.hasLoadMoreError = false,
  });

  @override
  bool get hasReachedEnd => nextPage == null;

  @override
  SavedOffersLoaded copyWith({
    List<Offer>? items,
    int? Function()? nextPage,
    int? itemsCount,
    bool? isLoadingMore,
    bool? hasLoadMoreError,
  }) {
    return SavedOffersLoaded(
      items: items ?? this.items,
      nextPage: nextPage != null ? nextPage() : this.nextPage,
      itemsCount: itemsCount ?? this.itemsCount,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasLoadMoreError: hasLoadMoreError ?? this.hasLoadMoreError,
    );
  }

  @override
  List<Object?> get props => [items, nextPage, itemsCount, isLoadingMore, hasLoadMoreError];
}

class SavedOffersError extends SavedOffersState {
  const SavedOffersError();
}
