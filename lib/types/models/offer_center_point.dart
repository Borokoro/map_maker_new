import 'package:equatable/equatable.dart';

class OfferCenterPoint extends Equatable {
  final double lat;
  final double lng;

  const OfferCenterPoint({required this.lat, required this.lng});

  factory OfferCenterPoint.fromJson(Map<String, dynamic> json) {
    return OfferCenterPoint(
      lat: (json["lat"] as num).toDouble(),
      lng: (json["lng"] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [lat, lng];
}