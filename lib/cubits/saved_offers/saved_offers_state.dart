part of 'saved_offers_cubit.dart';

abstract class SavedOffersState extends Equatable {
  const SavedOffersState();

  @override
  List<Object?> get props => [];
}

class SavedOffersLoading extends SavedOffersState {
  const SavedOffersLoading();
}

class SavedOffersLoaded extends SavedOffersState {
  final List<Offer> offers;

  const SavedOffersLoaded({required this.offers});

  @override
  List<Object?> get props => [offers];
}

class SavedOffersError extends SavedOffersState {
  const SavedOffersError();
}
