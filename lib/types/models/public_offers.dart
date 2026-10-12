import 'package:equatable/equatable.dart';
import 'package:map_maker_new/types/models/offer.dart';

class PublicOffers extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<Offer> results;

  const PublicOffers({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PublicOffers.fromJson(Map<String, dynamic> json) {
    return PublicOffers(
      count: json["count"] as int,
      next: json["next"] as String?,
      previous: json["previous"] as String?,
      results: (json["results"] as List<dynamic>)
          .map((offer) => Offer.fromJson(offer as Map<String, dynamic>))
          .toList(),
    );
  }

  bool get hasNextPage => next != null;

  @override
  List<Object?> get props => [count, next, previous, results];
}