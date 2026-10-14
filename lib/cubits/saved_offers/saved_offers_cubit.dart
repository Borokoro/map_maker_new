import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/cubits/cubit_pagination_mixin/paginated_state.dart';
import 'package:map_maker_new/cubits/cubit_pagination_mixin/pagination_mixin.dart';
import 'package:map_maker_new/services/pagination/paginated_response.dart';
import 'package:map_maker_new/services/saved_offers_service.dart';
import 'package:map_maker_new/types/models/offer.dart';

part 'saved_offers_state.dart';

class SavedOffersCubit extends Cubit<SavedOffersState>
    with PaginationMixin<Offer, SavedOffersState, SavedOffersLoaded> {
  SavedOffersCubit(this._savedOffersService) : super(const SavedOffersLoading());
  final SavedOffersService _savedOffersService;

  @override
  Future<PaginatedResponse<Offer>> Function(int page) get fetch =>
      (int page) => _savedOffersService.getSavedOffers(page: page);

  @override
  int get pageSize => SavedOffersService.pageSize;

  @override
  Object getItemId(Offer item) => item.offerId;

  Future<void> fetchSavedOffers() async {
    emit(const SavedOffersLoading());
    try {
      final PaginatedResponse<Offer> response = await fetchFirstPage();
      emit(SavedOffersLoaded(
        items: response.data,
        nextPage: response.nextPage,
        itemsCount: response.itemsCount,
      ));
    } catch (_) {
      emit(const SavedOffersError());
    }
  }

  Future<void> refreshSavedOffers() async {
    try {
      await refreshContent();
    } catch (_) {
      return;
    }
  }

  Future<bool> onUnsavePressed(String offerId) async {
    final SavedOffersState currentState = state;
    if (currentState is! SavedOffersLoaded) return true;
    final int index = currentState.items.indexWhere((Offer offer) => offer.offerId == offerId);
    if (index == -1) return true;
    final Offer removedOffer = currentState.items[index];
    emit(currentState.copyWith(
      items: currentState.items.where((Offer offer) => offer.offerId != offerId).toList(),
      itemsCount: currentState.itemsCount - 1,
    ));
    try {
      await _savedOffersService.unsaveOffer(offerId);
      return true;
    } catch (_) {
      _restoreOffer(removedOffer, index);
      return false;
    }
  }

  void _restoreOffer(Offer offer, int index) {
    final SavedOffersState currentState = state;
    if (currentState is! SavedOffersLoaded) return;
    final List<Offer> offers = List.of(currentState.items);
    offers.insert(index.clamp(0, offers.length), offer);
    emit(currentState.copyWith(items: offers, itemsCount: currentState.itemsCount + 1));
  }
}
