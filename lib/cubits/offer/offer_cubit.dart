import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/constants/app_constants.dart';
import 'package:map_maker_new/services/offer_service.dart';
import 'package:map_maker_new/services/saved_offers_service.dart';
import 'package:map_maker_new/types/enum/contact_failure_type.dart';
import 'package:map_maker_new/types/enum/offer_view_source.dart';
import 'package:map_maker_new/types/models/offer_contact.dart';
import 'package:map_maker_new/types/models/offer_details.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit(this._offerService, this._savedOffersService) : super(const OfferInitial());
  final OfferService _offerService;
  final SavedOffersService _savedOffersService;

  Future<void> fetchOffer(String offerId, {OfferViewSource? viewSource}) async {
    emit(const OfferLoading());
    try {
      final OfferDetails offerDetails = await _offerService.getOffer(offerId);
      if (isClosed) return;
      emit(OfferLoaded(offerDetails: offerDetails));
      if (viewSource != null) _registerView(offerId, viewSource);
    } on DioException catch (e) {
      if (isClosed) return;
      emit(OfferError(isNotFound: e.response?.statusCode == AppConstants.notFoundStatusCode));
    } catch (_) {
      if (isClosed) return;
      emit(const OfferError());
    }
  }

  Future<bool> onSaveOfferPressed() async {
    final OfferState currentState = state;
    if (currentState is! OfferLoaded) return true;
    final bool isSaved = currentState.offerDetails.offer.isSaved;
    final String offerId = currentState.offerDetails.offer.offerId;
    _emitSavedState(!isSaved);
    try {
      if (isSaved) {
        await _savedOffersService.unsaveOffer(offerId);
      } else {
        await _savedOffersService.saveOffer(offerId);
      }
      return true;
    } catch (_) {
      _emitSavedState(isSaved);
      return false;
    }
  }

  Future<void> onRevealContactPressed() async {
    final OfferState currentState = state;
    if (currentState is! OfferLoaded || currentState.isContactLoading) return;
    emit(currentState.copyWith(isContactLoading: true, contactFailure: () => null));
    try {
      final OfferContact contact = await _offerService.revealContact(currentState.offerDetails.offer.offerId);
      _emitLoadedState(
        (OfferLoaded latestState) => latestState.copyWith(contact: () => contact, isContactLoading: false),
      );
    } on DioException catch (e) {
      final ContactFailureType failure = e.response?.statusCode == AppConstants.notFoundStatusCode
          ? ContactFailureType.missing
          : ContactFailureType.other;
      _emitLoadedState(
        (OfferLoaded latestState) => latestState.copyWith(isContactLoading: false, contactFailure: () => failure),
      );
    } catch (_) {
      _emitLoadedState(
        (OfferLoaded latestState) =>
            latestState.copyWith(isContactLoading: false, contactFailure: () => ContactFailureType.other),
      );
    }
  }

  Future<void> _registerView(String offerId, OfferViewSource viewSource) async {
    try {
      await _offerService.registerView(offerId, viewSource);
    } catch (_) {
      return;
    }
  }

  void _emitSavedState(bool isSaved) {
    _emitLoadedState(
      (OfferLoaded latestState) =>
          latestState.copyWith(offerDetails: latestState.offerDetails.copyWith(isSaved: isSaved)),
    );
  }

  void _emitLoadedState(OfferLoaded Function(OfferLoaded latestState) buildState) {
    final OfferState latestState = state;
    if (isClosed || latestState is! OfferLoaded) return;
    emit(buildState(latestState));
  }
}
