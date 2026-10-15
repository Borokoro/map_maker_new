import 'package:map_maker_new/types/enum/access_road_type.dart';
import 'package:map_maker_new/types/enum/building_conditions.dart';
import 'package:map_maker_new/types/enum/encumbrance_type.dart';
import 'package:map_maker_new/types/enum/ownership_type.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/types/models/offer_photo.dart';
import 'package:map_maker_new/types/models/offer_plot.dart';

extension OfferDetailsExtension on OfferDetails {
  static const List<String> _webSchemes = ["http", "https"];

  int get plotsCountOrOne {
    if (plots.isNotEmpty) return plots.length;
    return offer.plotsCount > 0 ? offer.plotsCount : 1;
  }

  List<OfferPhoto> get visiblePhotos => photos.where((OfferPhoto photo) => (photo.url ?? "").isNotEmpty).toList();

  List<String> get locationParts {
    if (plots.isEmpty) return const [];
    final OfferPlot firstPlot = plots.first;
    return _unique([firstPlot.commune, firstPlot.voivodeship]);
  }

  bool get hasLocalPlanSymbols => offer.zoneSymbols.isNotEmpty;

  List<String> get planSymbols => hasLocalPlanSymbols ? offer.zoneSymbols : offer.pogZoneSymbols;

  OfferPlot? get firstPlotWithReport {
    for (final OfferPlot plot in plots) {
      if (plot.hasReport) return plot;
    }
    return null;
  }

  List<OfferPlot> get separatelyPricedPlots =>
      soldSeparately ? plots.where((OfferPlot plot) => plot.separatePrice != null).toList() : const [];

  List<AccessRoadType> get accessRoads => _unique(plots.expand((OfferPlot plot) => plot.accessRoad));

  bool? get roadAccessPublicEstimate {
    final List<bool?> estimates = plots.map((OfferPlot plot) => plot.roadAccessPublicEstimate).toList();
    if (estimates.contains(true)) return true;
    if (estimates.isNotEmpty && estimates.every((bool? estimate) => estimate == false)) return false;
    return null;
  }

  List<String> get landRegisterNumbers => _unique(plots.map((OfferPlot plot) => plot.landRegisterNumber));

  List<OwnershipType> get ownershipTypes => _unique(plots.map((OfferPlot plot) => plot.ownershipType));

  List<BuildingConditions> get buildingConditions => _unique(plots.map((OfferPlot plot) => plot.buildingConditions));

  List<EncumbranceType> get encumbrances => _unique(plots.expand((OfferPlot plot) => plot.encumbrances));

  Uri? get sourceUri {
    final Uri? uri = Uri.tryParse(sourceUrl);
    if (uri == null || !_webSchemes.contains(uri.scheme)) return null;
    return uri;
  }

  static List<T> _unique<T>(Iterable<T?> values) {
    final List<T> result = [];
    for (final T? value in values) {
      if (value == null || value == "" || result.contains(value)) continue;
      result.add(value);
    }
    return result;
  }
}
