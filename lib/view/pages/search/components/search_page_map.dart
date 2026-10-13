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
    required this.initMapController,
    this.selectedOfferId,
    this.searchedLocation,
    this.topPadding = 0,
    this.bottomPadding = 0,
  });

  final List<Offer> offers;
  final void Function(String) onOfferTap;
  final void Function() onMapTap;
  final void Function(MapboxMap) initMapController;
  final String? selectedOfferId;
  final String? searchedLocation;
  final double topPadding;
  final double bottomPadding;

  static final Point polandCenter = Point(coordinates: Position(19.4, 52.1));
  static const double polandZoom = 5.5;

  @override
  State<SearchPageMap> createState() => _SearchPageMapState();
}

class _SearchPageMapState extends State<SearchPageMap> {
  MapboxMap? _mapboxMap;
  OffersMapLayer? _offersMapLayer;
  late String? _shownLocation = widget.searchedLocation;

  static const double _tapRadius = 4;

  @override
  void didUpdateWidget(covariant SearchPageMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.offers != widget.offers || oldWidget.selectedOfferId != widget.selectedOfferId) {
      _offersMapLayer?.show(widget.offers, selectedOfferId: widget.selectedOfferId);
    }
    if (oldWidget.offers != widget.offers) {
      _moveToSearchedLocation();
    }
  }

  void _moveToSearchedLocation() {
    if (widget.searchedLocation == _shownLocation) return;
    _shownLocation = widget.searchedLocation;
    if (widget.searchedLocation == null) {
      _mapboxMap?.flyTo(
        CameraOptions(center: SearchPageMap.polandCenter, zoom: SearchPageMap.polandZoom),
        MapAnimationOptions(duration: OffersMapLayer.flyToDuration),
      );
    } else {
      _offersMapLayer?.zoomToOffers(widget.offers, topPadding: widget.topPadding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MapWidget(
      styleUri: MapboxStyles.STANDARD_SATELLITE,
      viewport: CameraViewportState(center: SearchPageMap.polandCenter, zoom: SearchPageMap.polandZoom),
      onMapCreated: _onMapCreated,
      onStyleLoadedListener: (_) => _onStyleLoaded(),
    );
  }

  void _onMapCreated(MapboxMap mapboxMap) {
    _mapboxMap = mapboxMap;
    widget.initMapController(mapboxMap);
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
          if (offerId is String) _onOfferTapped(offerId);
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

  void _onOfferTapped(String offerId) {
    widget.onOfferTap(offerId);
    for (final Offer offer in widget.offers) {
      if (offer.offerId != offerId) continue;
      _offersMapLayer?.zoomToOffer(
        offer,
        topPadding: widget.topPadding,
        bottomPadding: widget.bottomPadding,
      );
      return;
    }
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
    await offersMapLayer.show(widget.offers, selectedOfferId: widget.selectedOfferId);
  }
}
