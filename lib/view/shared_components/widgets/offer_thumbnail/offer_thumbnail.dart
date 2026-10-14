import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/types/models/preview_geojson.dart';
import 'package:map_maker_new/view/shared_components/widgets/offer_thumbnail/offer_geometry_painter.dart';

class OfferThumbnail extends StatelessWidget {
  const OfferThumbnail({
    super.key,
    this.size,
    this.photoUrl,
    this.geometry,
    this.borderRadius = StyleConstants.radius12,
    this.geometryPadding = 12,
  });

  final double? size;
  final String? photoUrl;
  final PreviewGeojson? geometry;
  final BorderRadius borderRadius;
  final double geometryPadding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: size,
        height: size,
        child: _getContent(),
      ),
    );
  }

  Widget _getContent() {
    final String? url = photoUrl;
    if (url == null || url.isEmpty) return _getGeometry();
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => _getGeometry(),
    );
  }

  Widget _getGeometry() {
    return ColoredBox(
      color: ColorConstants.bgSurfaceAlt,
      child: CustomPaint(painter: OfferGeometryPainter(geometry, geometryPadding)),
    );
  }
}
