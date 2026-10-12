import 'package:equatable/equatable.dart';
import 'package:map_maker_new/types/models/offer_center_point.dart';
import 'package:map_maker_new/types/models/offer_estimate.dart';
import 'package:map_maker_new/types/models/preview_geojson.dart';

class Offer extends Equatable {
  final String offerId;
  final String title;
  final String status;
  final String address;
  final String locationLabel;
  final double? price;
  final bool priceNegotiable;
  final double? pricePerMeter;
  final double? totalArea;
  final int plotsCount;
  final bool? buildable;
  final String planBasis;
  final String? designation;
  final List<String> designations;
  final bool? infillArea;
  final List<String> zoneSymbols;
  final List<String> pogZoneSymbols;
  final List<String> planTypes;
  final List<String> utilities;
  final bool? hasRoadAccess;
  final int? distanceToCityM;
  final OfferEstimate? estimate;
  final bool isSaved;
  final String? coverPhotoUrl;
  final OfferCenterPoint? centerPoint;
  final PreviewGeojson? previewGeojson;
  final DateTime? publishedAt;

  const Offer({
    required this.offerId,
    required this.title,
    required this.status,
    required this.address,
    required this.locationLabel,
    required this.price,
    required this.priceNegotiable,
    required this.pricePerMeter,
    required this.totalArea,
    required this.plotsCount,
    required this.buildable,
    required this.planBasis,
    required this.designation,
    required this.designations,
    required this.infillArea,
    required this.zoneSymbols,
    required this.pogZoneSymbols,
    required this.planTypes,
    required this.utilities,
    required this.hasRoadAccess,
    required this.distanceToCityM,
    required this.estimate,
    required this.isSaved,
    required this.coverPhotoUrl,
    required this.centerPoint,
    required this.previewGeojson,
    required this.publishedAt,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      offerId: json["offer_id"] as String,
      title: json["title"] as String? ?? "",
      status: json["status"] as String? ?? "",
      address: json["address"] as String? ?? "",
      locationLabel: json["location_label"] as String? ?? "",
      price: _parseDecimal(json["price"]),
      priceNegotiable: json["price_negotiable"] as bool? ?? false,
      pricePerMeter: _parseDecimal(json["price_per_meter"]),
      totalArea: _parseDecimal(json["total_area"]),
      plotsCount: json["plots_count"] as int? ?? 0,
      buildable: json["buildable"] as bool?,
      planBasis: json["plan_basis"] as String? ?? "",
      designation: json["designation"] as String?,
      designations: _parseStringList(json["designations"]),
      infillArea: json["infill_area"] as bool?,
      zoneSymbols: _parseStringList(json["zone_symbols"]),
      pogZoneSymbols: _parseStringList(json["pog_zone_symbols"]),
      planTypes: _parseStringList(json["plan_types"]),
      utilities: _parseStringList(json["utilities"]),
      hasRoadAccess: json["has_road_access"] as bool?,
      distanceToCityM: json["distance_to_city_m"] as int?,
      estimate: json["estimate"] == null
          ? null
          : OfferEstimate.fromJson(json["estimate"] as Map<String, dynamic>),
      isSaved: json["is_saved"] as bool? ?? false,
      coverPhotoUrl: json["cover_photo_url"] as String?,
      centerPoint: json["center_point"] == null
          ? null
          : OfferCenterPoint.fromJson(json["center_point"] as Map<String, dynamic>),
      previewGeojson: json["preview_geojson"] == null
          ? null
          : PreviewGeojson.fromJson(json["preview_geojson"] as Map<String, dynamic>),
      publishedAt: json["published_at"] == null
          ? null
          : DateTime.parse(json["published_at"] as String),
    );
  }

  static double? _parseDecimal(Object? value) {
    if (value == null) return null;
    return double.tryParse(value.toString());
  }

  static List<String> _parseStringList(Object? value) {
    if (value == null) return const [];
    return (value as List<dynamic>).cast<String>();
  }

  @override
  List<Object?> get props => [
    offerId,
    title,
    status,
    address,
    locationLabel,
    price,
    priceNegotiable,
    pricePerMeter,
    totalArea,
    plotsCount,
    buildable,
    planBasis,
    designation,
    designations,
    infillArea,
    zoneSymbols,
    pogZoneSymbols,
    planTypes,
    utilities,
    hasRoadAccess,
    distanceToCityM,
    estimate,
    isSaved,
    coverPhotoUrl,
    centerPoint,
    previewGeojson,
    publishedAt,
  ];
}

