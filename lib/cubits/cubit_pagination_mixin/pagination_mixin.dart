import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/cubits/cubit_pagination_mixin/paginated_state.dart';
import 'package:map_maker_new/services/pagination/paginated_response.dart';

mixin PaginationMixin<V, S, P extends PaginatedStateInfinityScroll<V>> on BlocBase<S> {
  static const int _firstPage = 1;

  Future<PaginatedResponse<V>> Function(int page) get fetch;

  int get pageSize;

  Object getItemId(V item);

  Future<PaginatedResponse<V>> fetchFirstPage() => fetch(_firstPage);

  Future<void> loadMore() async {
    final S currentState = state;
    if (currentState is! P || currentState.hasReachedEnd || currentState.isLoadingMore) return;
    emit(currentState.copyWith(isLoadingMore: true, hasLoadMoreError: false) as S);
    try {
      final PaginatedResponse<V> response = await fetch(currentState.items.length ~/ pageSize + _firstPage);
      _emitPaginatedState((P latestState) => latestState.copyWith(
        items: _mergeItems(latestState.items, response.data),
        nextPage: () => response.nextPage,
        itemsCount: response.itemsCount,
        isLoadingMore: false,
      ));
    } catch (_) {
      _emitPaginatedState((P latestState) => latestState.copyWith(isLoadingMore: false, hasLoadMoreError: true));
    }
  }

  Future<void> refreshContent() async {
    if (state is! P) return;
    final PaginatedResponse<V> response = await fetchFirstPage();
    _emitPaginatedState((P latestState) => latestState.copyWith(
      items: response.data,
      nextPage: () => response.nextPage,
      itemsCount: response.itemsCount,
      isLoadingMore: false,
      hasLoadMoreError: false,
    ));
  }

  void _emitPaginatedState(PaginatedStateInfinityScroll<V> Function(P latestState) buildState) {
    final S latestState = state;
    if (isClosed || latestState is! P) return;
    emit(buildState(latestState) as S);
  }

  List<V> _mergeItems(List<V> currentItems, List<V> newItems) {
    final Set<Object> currentIds = currentItems.map(getItemId).toSet();
    return [...currentItems, ...newItems.where((V item) => !currentIds.contains(getItemId(item)))];
  }
}
