import 'package:flutter/material.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/models/offer.dart';
import 'package:map_maker_new/view/pages/search/components/offers_map_layer.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class SearchPageMap extends StatefulWidget {
  const SearchPageMap({
    super.key,
    required this.offers,
    required this.onOfferTap,
    required this.onMapTap,
    this.searchedLocation,
    this.topPadding = 0,
  });

  final List<Offer> offers;
  final void Function(String) onOfferTap;
  final void Function() onMapTap;
  final String? searchedLocation;
  final double topPadding;

  @override
  State<SearchPageMap> createState() => _SearchPageMapState();
}

class _SearchPageMapState extends State<SearchPageMap> {
  MapboxMap? _mapboxMap;
  OffersMapLayer? _offersMapLayer;
  late String? _shownLocation = widget.searchedLocation;

  final Point _polandCenter = Point(coordinates: Position(19.4, 52.1));
  static const double _polandZoom = 5.5;
  static const double _tapRadius = 4;

  @override
  void didUpdateWidget(covariant SearchPageMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.offers != widget.offers) {
      _offersMapLayer?.show(widget.offers);
      _moveToSearchedLocation();
    }
  }

  void _moveToSearchedLocation() {
    if (widget.searchedLocation == _shownLocation) return;
    _shownLocation = widget.searchedLocation;
    if (widget.searchedLocation == null) {
      _mapboxMap?.flyTo(
        CameraOptions(center: _polandCenter, zoom: _polandZoom),
        MapAnimationOptions(duration: OffersMapLayer.flyToDuration),
      );
    } else {
      _offersMapLayer?.zoomToOffers(widget.offers, topPadding: widget.topPadding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MapWidget(
      styleUri: MapboxStyles.STANDARD,
      viewport: CameraViewportState(center: _polandCenter, zoom: _polandZoom),
      onMapCreated: _onMapCreated,
      onStyleLoadedListener: (_) => _onStyleLoaded(),
    );
  }

  void _onMapCreated(MapboxMap mapboxMap) {
    _mapboxMap = mapboxMap;
    _setOrnaments(mapboxMap);
    _addInteractions(mapboxMap);
  }

  void _setOrnaments(MapboxMap mapboxMap) {
    mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
    mapboxMap.compass.updateSettings(CompassSettings(enabled: false));
  }

  void _addInteractions(MapboxMap mapboxMap) {
    mapboxMap.addInteraction(
      TapInteraction(
        FeaturesetDescriptor(layerId: OffersMapLayer.offerPricesLayerId),
        (FeaturesetFeature feature, _) {
          final Object? offerId =
              feature.properties[OffersMapLayer.offerIdProperty];
          if (offerId is String) widget.onOfferTap(offerId);
          _offersMapLayer?.zoomToOffer(feature);
        },
        radius: _tapRadius,
      ),
    );
    mapboxMap.addInteraction(
      TapInteraction(
        FeaturesetDescriptor(layerId: OffersMapLayer.offerClustersLayerId),
        (FeaturesetFeature feature, _) =>
            _offersMapLayer?.expandCluster(feature),
        radius: _tapRadius,
      ),
    );
    mapboxMap.addInteraction(TapInteraction.onMap((_) => widget.onMapTap()));
  }

  Future<void> _onStyleLoaded() async {
    final MapboxMap? mapboxMap = _mapboxMap;
    if (mapboxMap == null || !mounted) return;
    final OffersMapLayer offersMapLayer = OffersMapLayer(
      mapboxMap,
      AppLocalizations.of(context)!,
    );
    await offersMapLayer.install(MediaQuery.devicePixelRatioOf(context));
    _offersMapLayer = offersMapLayer;
    await offersMapLayer.show(widget.offers);
  }
}
