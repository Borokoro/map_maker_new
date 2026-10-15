import 'package:equatable/equatable.dart';
import 'package:map_maker_new/types/enum/connection_location.dart';
import 'package:map_maker_new/types/enum/offer_utility.dart';
import 'package:map_maker_new/types/enum/plot_utility_status.dart';
import 'package:map_maker_new/types/enum/utility_source.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/types/models/plot_utility.dart';

class OfferUtilitySummary extends Equatable {
  final OfferUtility utility;
  final PlotUtilityStatus status;
  final double? distanceToNetwork;
  final ConnectionLocation? connectionLocation;
  final bool? connectionAccepted;
  final UtilitySource? source;

  const OfferUtilitySummary({
    required this.utility,
    required this.status,
    required this.distanceToNetwork,
    required this.connectionLocation,
    required this.connectionAccepted,
    required this.source,
  });

  factory OfferUtilitySummary.fromOfferDetails(OfferDetails offerDetails, OfferUtility utility) {
    final List<PlotUtility> plotUtilities = offerDetails.plots
        .expand((plot) => plot.utilities)
        .where((PlotUtility plotUtility) => plotUtility.utilityType == utility.apiValue)
        .toList();
    final List<PlotUtility> sortedUtilities = [...plotUtilities]
      ..sort((PlotUtility a, PlotUtility b) => a.status.index.compareTo(b.status.index));
    final PlotUtility? bestUtility = sortedUtilities.isEmpty ? null : sortedUtilities.first;
    final PlotUtilityStatus status =
        bestUtility?.status ??
        (offerDetails.offer.utilities.contains(utility.apiValue)
            ? PlotUtilityStatus.listed
            : PlotUtilityStatus.unknown);
    final List<PlotUtility> matchingUtilities = plotUtilities
        .where((PlotUtility plotUtility) => plotUtility.status == status)
        .toList();
    final bool hasDeclaration = status.hasConnectionDeclaration;
    final List<UtilitySource?> sources = matchingUtilities
        .map((PlotUtility plotUtility) => plotUtility.source)
        .toList();

    return OfferUtilitySummary(
      utility: utility,
      status: status,
      distanceToNetwork: bestUtility?.distanceToNetwork,
      connectionLocation: hasDeclaration
          ? _getCommonValue(matchingUtilities.map((PlotUtility plotUtility) => plotUtility.connectionLocation))
          : null,
      connectionAccepted: hasDeclaration
          ? _getCommonValue(matchingUtilities.map((PlotUtility plotUtility) => plotUtility.connectionAccepted))
          : null,
      source: sources.contains(UtilitySource.owner)
          ? UtilitySource.owner
          : sources.contains(UtilitySource.detected)
          ? UtilitySource.detected
          : null,
    );
  }

  static List<OfferUtilitySummary> listFromOfferDetails(OfferDetails offerDetails) {
    final List<OfferUtilitySummary> summaries = [];
    for (final OfferUtility utility in OfferUtility.values) {
      summaries.add(OfferUtilitySummary.fromOfferDetails(offerDetails, utility));
    }
    return summaries;
  }

  static T? _getCommonValue<T>(Iterable<T?> values) {
    if (values.isEmpty) return null;
    final T? firstValue = values.first;
    return values.every((T? value) => value == firstValue) ? firstValue : null;
  }

  @override
  List<Object?> get props => [utility, status, distanceToNetwork, connectionLocation, connectionAccepted, source];
}
