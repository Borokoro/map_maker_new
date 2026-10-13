import 'package:equatable/equatable.dart';

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

class OfferLocationCount extends Equatable {
  final String name;
  final int count;

  const OfferLocationCount({required this.name, required this.count});

  factory OfferLocationCount.fromJson(Map<String, dynamic> json) {
    return OfferLocationCount(
      name: json["name"] as String,
      count: json["count"] as int? ?? 0,
    );
  }

  @override
  List<Object?> get props => [name, count];
}
