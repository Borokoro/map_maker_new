import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/services/saved_offers_service.dart';
import 'package:map_maker_new/types/models/offer.dart';
import 'package:map_maker_new/types/models/public_offers.dart';

part 'saved_offers_state.dart';

class SavedOffersCubit extends Cubit<SavedOffersState> {
  SavedOffersCubit(this._savedOffersService) : super(const SavedOffersLoading());
  final SavedOffersService _savedOffersService;

  Future<void> fetchSavedOffers() async {
    emit(const SavedOffersLoading());
    try {
      final PublicOffers savedOffers = await _savedOffersService.getSavedOffers();
      emit(SavedOffersLoaded(offers: savedOffers.results));
    } catch (_) {
      emit(const SavedOffersError());
    }
  }

  Future<void> refreshSavedOffers() async {
    if (state is! SavedOffersLoaded) return;
    try {
      final PublicOffers savedOffers = await _savedOffersService.getSavedOffers();
      emit(SavedOffersLoaded(offers: savedOffers.results));
    } catch (_) {
      return;
    }
  }

  Future<bool> onUnsavePressed(String offerId) async {
    final SavedOffersState currentState = state;
    if (currentState is! SavedOffersLoaded) return true;
    final int index = currentState.offers.indexWhere((Offer offer) => offer.offerId == offerId);
    if (index == -1) return true;
    final Offer removedOffer = currentState.offers[index];
    emit(SavedOffersLoaded(
      offers: currentState.offers.where((Offer offer) => offer.offerId != offerId).toList(),
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
    final List<Offer> offers = List.of(currentState.offers);
    offers.insert(index.clamp(0, offers.length), offer);
    emit(SavedOffersLoaded(offers: offers));
  }
}
