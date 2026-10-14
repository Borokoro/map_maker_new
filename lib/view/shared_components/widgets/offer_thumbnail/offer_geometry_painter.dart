import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/types/models/preview_geojson.dart';

class OfferGeometryPainter extends CustomPainter {
  OfferGeometryPainter(this.geometry, this.padding);

  final PreviewGeojson? geometry;
  final double padding;

  static const double _strokeWidth = 1.5;
  static const double _fillOpacity = 0.15;

  @override
  void paint(Canvas canvas, Size size) {
    final List<List<List<double>>> rings = [
      for (final List<List<List<double>>> polygon in geometry?.coordinates ?? const []) ...polygon,
    ];
    final List<List<double>> points = [
      for (final List<List<double>> ring in rings) ...ring.where((point) => point.length >= 2),
    ];
    if (points.isEmpty) return;

    final double minLng = points.map((point) => point[0]).reduce(math.min);
    final double maxLng = points.map((point) => point[0]).reduce(math.max);
    final double minLat = points.map((point) => point[1]).reduce(math.min);
    final double maxLat = points.map((point) => point[1]).reduce(math.max);
    final double lngScale = math.cos((minLat + maxLat) / 2 * math.pi / 180);
    final double width = math.max((maxLng - minLng) * lngScale, 1e-9);
    final double height = math.max(maxLat - minLat, 1e-9);
    final double scale = math.min((size.width - padding * 2) / width, (size.height - padding * 2) / height);
    final double offsetX = (size.width - width * scale) / 2;
    final double offsetY = (size.height - height * scale) / 2;

    Offset project(List<double> point) => Offset(
      offsetX + (point[0] - minLng) * lngScale * scale,
      offsetY + (maxLat - point[1]) * scale,
    );

    final Path path = Path();
    for (final List<List<double>> ring in rings) {
      final List<List<double>> ringPoints = ring.where((point) => point.length >= 2).toList();
      if (ringPoints.isEmpty) continue;
      path.addPolygon(ringPoints.map(project).toList(), true);
    }
    canvas
      ..drawPath(path, Paint()..color = ColorConstants.bgBrand.withValues(alpha: _fillOpacity))
      ..drawPath(
        path,
        Paint()
          ..color = ColorConstants.bgBrand
          ..style = PaintingStyle.stroke
          ..strokeWidth = _strokeWidth,
      );
  }

  @override
  bool shouldRepaint(covariant OfferGeometryPainter oldDelegate) =>
      oldDelegate.geometry != geometry || oldDelegate.padding != padding;
}
