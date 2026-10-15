import 'package:equatable/equatable.dart';
import 'package:map_maker_new/types/enum/access_road_type.dart';
import 'package:map_maker_new/types/enum/building_conditions.dart';
import 'package:map_maker_new/types/enum/encumbrance_type.dart';
import 'package:map_maker_new/types/enum/ownership_type.dart';
import 'package:map_maker_new/types/models/plot_document.dart';
import 'package:map_maker_new/types/models/plot_utility.dart';
import 'package:map_maker_new/utils/json_parser.dart';

class OfferPlot extends Equatable {
  final String plotId;
  final String plotNumber;
  final String parcelNumber;
  final String voivodeship;
  final String commune;
  final double? area;
  final double? separatePrice;
  final String planBasis;
  final String? designation;
  final List<String> designations;
  final bool? infillArea;
  final bool hasReport;
  final String landRegisterNumber;
  final OwnershipType? ownershipType;
  final BuildingConditions? buildingConditions;
  final List<EncumbranceType> encumbrances;
  final List<AccessRoadType> accessRoad;
  final bool? roadAccessPublicEstimate;
  final List<PlotUtility> utilities;
  final List<PlotDocument> documents;

  const OfferPlot({
    required this.plotId,
    required this.plotNumber,
    required this.parcelNumber,
    required this.voivodeship,
    required this.commune,
    required this.area,
    required this.separatePrice,
    required this.planBasis,
    required this.designation,
    required this.designations,
    required this.infillArea,
    required this.hasReport,
    required this.landRegisterNumber,
    required this.ownershipType,
    required this.buildingConditions,
    required this.encumbrances,
    required this.accessRoad,
    required this.roadAccessPublicEstimate,
    required this.utilities,
    required this.documents,
  });

  factory OfferPlot.fromJson(Map<String, dynamic> json) {
    return OfferPlot(
      plotId: json["plot_id"] as String,
      plotNumber: json["plot_number"] as String? ?? "",
      parcelNumber: json["parcel_number"] as String? ?? "",
      voivodeship: json["voivodeship"] as String? ?? "",
      commune: json["commune"] as String? ?? "",
      area: JsonParser.parseDecimal(json["area"]),
      separatePrice: JsonParser.parseDecimal(json["separate_price"]),
      planBasis: json["plan_basis"] as String? ?? "",
      designation: json["designation"] as String?,
      designations: JsonParser.parseStringList(json["designations"]),
      infillArea: json["infill_area"] as bool?,
      hasReport: json["has_report"] as bool? ?? false,
      landRegisterNumber: (json["land_register_number"] as String? ?? "").trim(),
      ownershipType: OwnershipType.fromApiValue(json["ownership_type"] as String?),
      buildingConditions: BuildingConditions.fromApiValue(json["building_conditions"] as String?),
      encumbrances: JsonParser.parseEnumList(json["encumbrances"], EncumbranceType.fromApiValue),
      accessRoad: JsonParser.parseEnumList(json["access_road"], AccessRoadType.fromApiValue),
      roadAccessPublicEstimate: json["road_access_public_estimate"] as bool?,
      utilities: JsonParser.parseList(json["utilities"], PlotUtility.fromJson),
      documents: JsonParser.parseList(json["documents"], PlotDocument.fromJson),
    );
  }

  String get displayNumber => parcelNumber.isNotEmpty ? parcelNumber : plotNumber;

  @override
  List<Object?> get props => [
    plotId,
    plotNumber,
    parcelNumber,
    voivodeship,
    commune,
    area,
    separatePrice,
    planBasis,
    designation,
    designations,
    infillArea,
    hasReport,
    landRegisterNumber,
    ownershipType,
    buildingConditions,
    encumbrances,
    accessRoad,
    roadAccessPublicEstimate,
    utilities,
    documents,
  ];
}
