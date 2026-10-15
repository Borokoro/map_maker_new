part of 'offer_cubit.dart';

abstract class OfferState extends Equatable {
  const OfferState();

  @override
  List<Object?> get props => [];
}

class OfferInitial extends OfferState {
  const OfferInitial();
}

class OfferLoading extends OfferState {
  const OfferLoading();
}

class OfferLoaded extends OfferState {
  final OfferDetails offerDetails;
  final OfferContact? contact;
  final bool isContactLoading;
  final ContactFailureType? contactFailure;

  const OfferLoaded({required this.offerDetails, this.contact, this.isContactLoading = false, this.contactFailure});

  OfferLoaded copyWith({
    OfferDetails? offerDetails,
    OfferContact? Function()? contact,
    bool? isContactLoading,
    ContactFailureType? Function()? contactFailure,
  }) {
    return OfferLoaded(
      offerDetails: offerDetails ?? this.offerDetails,
      contact: contact != null ? contact() : this.contact,
      isContactLoading: isContactLoading ?? this.isContactLoading,
      contactFailure: contactFailure != null ? contactFailure() : this.contactFailure,
    );
  }

  @override
  List<Object?> get props => [offerDetails, contact, isContactLoading, contactFailure];
}

class OfferError extends OfferState {
  final bool isNotFound;

  const OfferError({this.isNotFound = false});

  @override
  List<Object?> get props => [isNotFound];
}
