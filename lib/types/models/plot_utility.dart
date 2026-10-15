import 'package:equatable/equatable.dart';
import 'package:map_maker_new/types/enum/connection_location.dart';
import 'package:map_maker_new/types/enum/plot_utility_status.dart';
import 'package:map_maker_new/types/enum/utility_source.dart';
import 'package:map_maker_new/utils/json_parser.dart';

class PlotUtility extends Equatable {
  final String utilityType;
  final PlotUtilityStatus status;
  final double? distanceToNetwork;
  final ConnectionLocation? connectionLocation;
  final bool? connectionAccepted;
  final UtilitySource? source;

  const PlotUtility({
    required this.utilityType,
    required this.status,
    required this.distanceToNetwork,
    required this.connectionLocation,
    required this.connectionAccepted,
    required this.source,
  });

  factory PlotUtility.fromJson(Map<String, dynamic> json) {
    return PlotUtility(
      utilityType: json["utility_type"] as String? ?? "",
      status: PlotUtilityStatus.fromApiValue(json["status"] as String?),
      distanceToNetwork: JsonParser.parseDecimal(json["distance_to_network"]),
      connectionLocation: ConnectionLocation.fromApiValue(json["connection_location"] as String?),
      connectionAccepted: json["connection_accepted"] as bool?,
      source: UtilitySource.fromApiValue(json["source"] as String?),
    );
  }

  @override
  List<Object?> get props => [utilityType, status, distanceToNetwork, connectionLocation, connectionAccepted, source];
}
