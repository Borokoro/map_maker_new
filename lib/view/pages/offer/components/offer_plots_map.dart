import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/types/models/offer_center_point.dart';
import 'package:map_maker_new/types/models/preview_geojson.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class OfferPlotsMap extends StatefulWidget {
  const OfferPlotsMap({
    super.key,
    required this.geometry,
    required this.centerPoint,
    required this.styleUri,
  });

  final PreviewGeojson? geometry;
  final OfferCenterPoint centerPoint;
  final String styleUri;

  @override
  State<OfferPlotsMap> createState() => _OfferPlotsMapState();
}

class _OfferPlotsMapState extends State<OfferPlotsMap> {
  static const String _shapesSourceId = "offer-plots-shapes";
  static const String _fillLayerId = "offer-plots-fill";
  static const String _lineLayerId = "offer-plots-line";
  static const Color _accentColor = ColorConstants.bgBrand;
  static const double _fillOpacity = 0.25;
  static const double _lineWidth = 3;
  static const double _initialZoom = 15;
  static const double _maxZoom = 17;
  static const double _shapesPadding = 40;

  MapboxMap? _mapboxMap;
  bool _isCameraFitted = false;

  @override
  void didUpdateWidget(covariant OfferPlotsMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.styleUri != widget.styleUri) {
      _mapboxMap?.loadStyleURI(widget.styleUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MapWidget(
      styleUri: widget.styleUri,
      viewport: CameraViewportState(
        center: Point(coordinates: Position(widget.centerPoint.lng, widget.centerPoint.lat)),
        zoom: _initialZoom,
      ),
      onMapCreated: _onMapCreated,
      onStyleLoadedListener: (_) => _onStyleLoaded(),
    );
  }

  void _onMapCreated(MapboxMap mapboxMap) {
    _mapboxMap = mapboxMap;
    mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
    mapboxMap.compass.updateSettings(CompassSettings(enabled: false));
    mapboxMap.gestures.updateSettings(
      GesturesSettings(
        scrollEnabled: false,
        rotateEnabled: false,
        pitchEnabled: false,
        pinchToZoomEnabled: false,
        doubleTapToZoomInEnabled: false,
        doubleTouchToZoomOutEnabled: false,
        quickZoomEnabled: false,
      ),
    );
  }

  Future<void> _onStyleLoaded() async {
    final MapboxMap? mapboxMap = _mapboxMap;
    final PreviewGeojson? geometry = widget.geometry;
    if (mapboxMap == null || geometry == null) return;
    await mapboxMap.addSource(GeoJsonSource(id: _shapesSourceId, data: jsonEncode(_getShapesFeature(geometry))));
    await mapboxMap.addLayer(
      FillLayer(
        id: _fillLayerId,
        sourceId: _shapesSourceId,
        fillColor: _accentColor.toARGB32(),
        fillOpacity: _fillOpacity,
      ),
    );
    await mapboxMap.addLayer(
      LineLayer(
        id: _lineLayerId,
        sourceId: _shapesSourceId,
        lineColor: _accentColor.toARGB32(),
        lineWidth: _lineWidth,
      ),
    );
    if (!_isCameraFitted) await _fitCameraToShapes(mapboxMap, geometry);
  }

  Future<void> _fitCameraToShapes(MapboxMap mapboxMap, PreviewGeojson geometry) async {
    final List<Point> points = [];
    for (final List<List<List<double>>> polygon in geometry.coordinates) {
      for (final List<List<double>> ring in polygon) {
        for (final List<double> point in ring) {
          if (point.length >= 2) {
            points.add(Point(coordinates: Position(point[0], point[1])));
          }
        }
      }
    }
    if (points.length < 2) return;
    final CameraOptions camera = await mapboxMap.cameraForCoordinatesPadding(
      points,
      CameraOptions(),
      MbxEdgeInsets(top: _shapesPadding, left: _shapesPadding, bottom: _shapesPadding, right: _shapesPadding),
      _maxZoom,
      null,
    );
    await mapboxMap.setCamera(camera);
    _isCameraFitted = true;
  }

  Map<String, dynamic> _getShapesFeature(PreviewGeojson geometry) {
    return {
      "type": "Feature",
      "geometry": {
        "type": geometry.type,
        "coordinates": geometry.coordinates,
      },
      "properties": <String, dynamic>{},
    };
  }
}
