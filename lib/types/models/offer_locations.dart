import 'package:equatable/equatable.dart';
import 'package:map_maker_new/types/models/offer_location_count.dart';

class OfferLocations extends Equatable {
  final List<OfferLocationCount> voivodeships;
  final List<OfferLocationCount> counties;
  final List<OfferLocationCount> communes;

  const OfferLocations({
    required this.voivodeships,
    required this.counties,
    required this.communes,
  });

  factory OfferLocations.fromJson(Map<String, dynamic> json) {
    return OfferLocations(
      voivodeships: _parseLocations(json["voivodeships"]),
      counties: _parseLocations(json["counties"]),
      communes: _parseLocations(json["communes"]),
    );
  }

  static List<OfferLocationCount> _parseLocations(Object? value) {
    if (value == null) return const [];
    return (value as List<dynamic>)
        .map((location) => OfferLocationCount.fromJson(location as Map<String, dynamic>))
        .toList();
  }

  @override
  List<Object?> get props => [voivodeships, counties, communes];
}
