import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/models/offer.dart';
import 'package:map_maker_new/types/models/offer_center_point.dart';
import 'package:map_maker_new/types/models/preview_geojson.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class OffersMapLayer {
  OffersMapLayer(this._mapboxMap, this._localizations);

  final MapboxMap _mapboxMap;
  final AppLocalizations _localizations;

  static const String offerPricesLayerId = 'offers-prices';
  static const String offerClustersLayerId = 'offers-clusters';
  static const String offerIdProperty = 'offer_id';

  static const String _pointsSourceId = 'offers-points';
  static const String _shapesSourceId = 'offers-shapes';
  static const String _fillLayerId = 'offers-fill';
  static const String _lineLayerId = 'offers-line';
  static const String _pricePillImageId = 'offer-price-pill';
  static const String _clusterPillImageId = 'offer-cluster-pill';
  static const String _selectedPricePillImageId = 'offer-selected-price-pill';
  static const String _selectedProperty = 'selected';
  static const String _labelProperty = 'label';
  static const String _emptyGeoJson =
      '{"type":"FeatureCollection","features":[]}';
  static const String _shortNumberPattern = '0.#';

  static const Color _accentColor = ColorConstants.bgBrand;
  static const double _shapesMinZoom = 11;
  static const double _shapesFillOpacity = 0.18;
  static const double _shapesLineWidth = 2;
  static const double _clusterRadius = 60;
  static const double _clusterMaxZoom = 12;
  static const double _labelTextSize = 14;
  static const double _maxZoom = 16;
  static const double _offerZoom = 15;
  static const double _selectedOfferMaxZoom = 16;
  static const double _selectedShapeFillOpacity = 0.3;
  static const double _selectedShapeLineWidth = 3;
  static const int flyToDuration = 900;
  static const double _resultsPadding = 48;
  static const double _pillSize = 28;
  static const double _pillBorderWidth = 1.5;

  Future<void> install(double pixelRatio) async {
    await _addPillImages(pixelRatio);
    await _addShapesLayers();
    await _addPointsLayers();
  }

  Future<void> show(List<Offer> offers, {String? selectedOfferId}) async {
    await _updateSource(_pointsSourceId, _getPointsFeatureCollection(offers, selectedOfferId));
    await _updateSource(_shapesSourceId, _getShapesFeatureCollection(offers, selectedOfferId));
  }

  Future<void> expandCluster(FeaturesetFeature cluster) async {
    final Position? center = _getFeaturePosition(cluster);
    if (center == null) return;
    final double currentZoom = (await _mapboxMap.getCameraState()).zoom;
    double zoom = currentZoom + 2;
    try {
      final FeatureExtensionValue result = await _mapboxMap
          .getGeoJsonClusterExpansionZoom(_pointsSourceId, {
            'type': 'Feature',
            'geometry': cluster.geometry,
            'properties': cluster.properties,
          });
      final double expansionZoom = double.parse(result.value!) + 1;
      if (expansionZoom > zoom) zoom = expansionZoom;
    } catch (_) {}
    await _flyTo(center, zoom.clamp(0, _maxZoom).toDouble());
  }

  Future<void> zoomToOffers(List<Offer> offers, {double topPadding = 0}) async {
    final List<Point> points = [
      for (final Offer offer in offers)
        if (offer.centerPoint case final OfferCenterPoint centerPoint)
          Point(coordinates: Position(centerPoint.lng, centerPoint.lat)),
    ];
    if (points.isEmpty) return;
    if (points.length == 1) {
      await _flyTo(points.first.coordinates, _offerZoom);
      return;
    }
    final CameraOptions camera = await _mapboxMap.cameraForCoordinatesPadding(
      points,
      CameraOptions(),
      MbxEdgeInsets(
        top: topPadding + _resultsPadding,
        left: _resultsPadding,
        bottom: _resultsPadding,
        right: _resultsPadding,
      ),
      _offerZoom,
      null,
    );
    await _mapboxMap.flyTo(camera, MapAnimationOptions(duration: flyToDuration));
  }

  Future<void> zoomToOffer(Offer offer, {double topPadding = 0, double bottomPadding = 0}) async {
    final List<Point> shapePoints = [
      for (final List<List<List<double>>> polygon in offer.previewGeojson?.coordinates ?? const [])
        for (final List<List<double>> ring in polygon)
          for (final List<double> point in ring)
            if (point.length >= 2) Point(coordinates: Position(point[0], point[1])),
    ];
    final OfferCenterPoint? centerPoint = offer.centerPoint;
    if (shapePoints.length < 2) {
      if (centerPoint == null) return;
      await _flyTo(
        Position(centerPoint.lng, centerPoint.lat),
        _selectedOfferMaxZoom,
        topPadding: topPadding,
        bottomPadding: bottomPadding,
      );
      return;
    }
    final CameraOptions camera = await _mapboxMap.cameraForCoordinatesPadding(
      shapePoints,
      CameraOptions(),
      MbxEdgeInsets(
        top: topPadding + _resultsPadding,
        left: _resultsPadding,
        bottom: bottomPadding + _resultsPadding,
        right: _resultsPadding,
      ),
      _selectedOfferMaxZoom,
      null,
    );
    await _mapboxMap.flyTo(camera, MapAnimationOptions(duration: flyToDuration));
  }

  Future<void> _addPillImages(double pixelRatio) async {
    await _mapboxMap.addImage(
      _pricePillImageId,
      pixelRatio,
      await _getPillImage(pixelRatio, Colors.white, Colors.black26),
      stretchX: _getPillStretches(pixelRatio),
      stretchY: _getPillStretches(pixelRatio),
    );
    await _mapboxMap.addImage(
      _selectedPricePillImageId,
      pixelRatio,
      await _getPillImage(pixelRatio, _accentColor, _accentColor),
      stretchX: _getPillStretches(pixelRatio),
      stretchY: _getPillStretches(pixelRatio),
    );
    await _mapboxMap.addImage(
      _clusterPillImageId,
      pixelRatio,
      await _getPillImage(pixelRatio, Colors.white, _accentColor),
      stretchX: _getPillStretches(pixelRatio),
      stretchY: _getPillStretches(pixelRatio),
    );
  }

  Future<void> _addShapesLayers() async {
    await _mapboxMap.addSource(
      GeoJsonSource(id: _shapesSourceId, data: _emptyGeoJson),
    );
    await _mapboxMap.addLayer(
      FillLayer(
        id: _fillLayerId,
        sourceId: _shapesSourceId,
        minZoom: _shapesMinZoom,
        fillColor: _accentColor.toARGB32(),
        fillOpacityExpression: _getSelectedCaseExpression(_selectedShapeFillOpacity, _shapesFillOpacity),
      ),
    );
    await _mapboxMap.addLayer(
      LineLayer(
        id: _lineLayerId,
        sourceId: _shapesSourceId,
        minZoom: _shapesMinZoom,
        lineColor: _accentColor.toARGB32(),
        lineWidthExpression: _getSelectedCaseExpression(_selectedShapeLineWidth, _shapesLineWidth),
      ),
    );
  }

  Future<void> _addPointsLayers() async {
    await _mapboxMap.addSource(
      GeoJsonSource(
        id: _pointsSourceId,
        data: _emptyGeoJson,
        cluster: true,
        clusterRadius: _clusterRadius,
        clusterMaxZoom: _clusterMaxZoom,
      ),
    );
    await _mapboxMap.addLayer(
      SymbolLayer(
        id: offerClustersLayerId,
        sourceId: _pointsSourceId,
        filter: ['has', 'point_count'],
        iconImage: _clusterPillImageId,
        iconTextFit: IconTextFit.BOTH,
        iconTextFitPadding: [5, 12, 5, 12],
        iconAllowOverlap: true,
        textAllowOverlap: true,
        textFieldExpression: [
          'concat',
          ['to-string', ['get', 'point_count']],
          _getPluralSuffixExpression(['get', 'point_count']),
        ],
        textSize: _labelTextSize,
        textColor: _accentColor.toARGB32(),
        textFont: ['DIN Pro Medium', 'Arial Unicode MS Regular'],
      ),
    );
    await _mapboxMap.addLayer(
      SymbolLayer(
        id: offerPricesLayerId,
        sourceId: _pointsSourceId,
        filter: ['!', ['has', 'point_count']],
        iconImageExpression: _getSelectedCaseExpression(_selectedPricePillImageId, _pricePillImageId),
        iconTextFit: IconTextFit.BOTH,
        iconTextFitPadding: [5, 10, 5, 10],
        iconAllowOverlap: true,
        textAllowOverlap: true,
        symbolSortKeyExpression: _getSelectedCaseExpression(1, 0),
        textFieldExpression: ['get', _labelProperty],
        textSize: _labelTextSize,
        textColorExpression: _getSelectedCaseExpression(
          _getColorExpression(ColorConstants.textOnBrand),
          _getColorExpression(Colors.black),
        ),
        textFont: ['DIN Pro Bold', 'Arial Unicode MS Bold'],
      ),
    );
  }

  List<Object> _getSelectedCaseExpression(Object selectedValue, Object defaultValue) {
    return ['case', ['==', ['get', _selectedProperty], true], selectedValue, defaultValue];
  }

  List<Object> _getColorExpression(Color color) {
    return [
      'rgba',
      (color.r * 255).round(),
      (color.g * 255).round(),
      (color.b * 255).round(),
      color.a,
    ];
  }

  Map<String, dynamic> _getPointsFeatureCollection(List<Offer> offers, String? selectedOfferId) {
    return {
      'type': 'FeatureCollection',
      'features': [
        for (final Offer offer in offers)
          if (offer.centerPoint case final OfferCenterPoint centerPoint)
            {
              'type': 'Feature',
              'geometry': {
                'type': 'Point',
                'coordinates': [centerPoint.lng, centerPoint.lat],
              },
              'properties': {
                offerIdProperty: offer.offerId,
                _labelProperty: _getShortPrice(offer.price),
                _selectedProperty: offer.offerId == selectedOfferId,
              },
            },
      ],
    };
  }

  Map<String, dynamic> _getShapesFeatureCollection(List<Offer> offers, String? selectedOfferId) {
    return {
      'type': 'FeatureCollection',
      'features': [
        for (final Offer offer in offers)
          if (offer.previewGeojson case final PreviewGeojson previewGeojson)
            {
              'type': 'Feature',
              'geometry': {
                'type': previewGeojson.type,
                'coordinates': previewGeojson.coordinates,
              },
              'properties': {
                offerIdProperty: offer.offerId,
                _selectedProperty: offer.offerId == selectedOfferId,
              },
            },
      ],
    };
  }

  Future<void> _flyTo(
    Position center,
    double zoom, {
    double topPadding = 0,
    double bottomPadding = 0,
  }) {
    return _mapboxMap.flyTo(
      CameraOptions(
        center: Point(coordinates: center),
        zoom: zoom,
        padding: MbxEdgeInsets(
          top: topPadding,
          left: 0,
          bottom: bottomPadding,
          right: 0,
        ),
      ),
      MapAnimationOptions(duration: flyToDuration),
    );
  }

  Position? _getFeaturePosition(FeaturesetFeature feature) {
    final List<num>? coordinates = (feature.geometry['coordinates'] as List?)
        ?.cast<num>();
    if (coordinates == null || coordinates.length < 2) return null;
    return Position(coordinates[0], coordinates[1]);
  }

  Future<void> _updateSource(String sourceId, Map<String, dynamic> data) async {
    final Source? source = await _mapboxMap.getSource(sourceId);
    if (source is GeoJsonSource) await source.updateGeoJSON(jsonEncode(data));
  }

  String _getShortPrice(double? price) {
    if (price == null) return _localizations.mapPriceOnRequest;
    if (price >= 1000000) {
      final NumberFormat millionsFormat = NumberFormat(_shortNumberPattern, _localizations.localeName);
      return _localizations.mapPriceMillions(millionsFormat.format(price / 1000000));
    }
    return _localizations.mapPriceThousands((price / 1000).round().toString());
  }

  List<Object> _getPluralSuffixExpression(List<Object> count) {
    return [
      'case',
      [
        'all',
        ['>=', ['%', count, 10], 2],
        ['<=', ['%', count, 10], 4],
        [
          '!',
          [
            'all',
            ['>=', ['%', count, 100], 12],
            ['<=', ['%', count, 100], 14],
          ],
        ],
      ],
      _localizations.mapClusterOffersFew,
      _localizations.mapClusterOffersMany,
    ];
  }

  List<ImageStretches> _getPillStretches(double pixelRatio) {
    return [
      ImageStretches(
        first: (_pillSize / 2 - 1) * pixelRatio,
        second: (_pillSize / 2 + 1) * pixelRatio,
      ),
    ];
  }

  Future<StyleImage> _getPillImage(
    double pixelRatio,
    Color fillColor,
    Color borderColor,
  ) async {
    final int size = (_pillSize * pixelRatio).round();
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder)..scale(pixelRatio);
    final RRect pill = RRect.fromRectAndRadius(
      const Rect.fromLTWH(1, 1, _pillSize - 2, _pillSize - 2),
      const Radius.circular(_pillSize / 2 - 1),
    );
    canvas
      ..drawRRect(pill, Paint()..color = fillColor)
      ..drawRRect(
        pill,
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = _pillBorderWidth,
      );
    final ui.Image image = await recorder.endRecording().toImage(size, size);
    final ByteData? bytes = await image.toByteData(
      format: ui.ImageByteFormat.rawRgba,
    );
    return StyleImage.rgba(
      width: size,
      height: size,
      pixels: bytes!.buffer.asUint8List(),
    );
  }
}
