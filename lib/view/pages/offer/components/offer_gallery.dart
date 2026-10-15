import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/types/models/offer_photo.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_details_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/shared_components/widgets/offer_thumbnail/offer_thumbnail.dart';
import 'package:map_maker_new/utils/offer_formatters.dart';

class OfferGallery extends StatefulWidget {
  const OfferGallery({super.key, required this.offerDetails});

  final OfferDetails offerDetails;

  @override
  State<OfferGallery> createState() => _OfferGalleryState();
}

class _OfferGalleryState extends State<OfferGallery> {
  static const double _height = 260;
  static const double _overlayOffset = 12;
  static const double _geometryPadding = 40;
  static const double _badgeIconSize = 14;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<OfferPhoto> photos = widget.offerDetails.visiblePhotos;
    final int pagesCount = photos.length + 1;

    return SizedBox(
      height: _height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            itemCount: pagesCount,
            onPageChanged: (int index) => setState(() => _currentIndex = index),
            itemBuilder: (BuildContext context, int index) =>
                index < photos.length ? _getPhoto(photos[index]) : _getGeometry(),
          ),
          if (_currentIndex < photos.length && photos[_currentIndex].takenOnPlot) ...{
            Positioned(
              top: _overlayOffset,
              left: _overlayOffset,
              child: _getTakenOnPlotBadge(context, photos[_currentIndex]),
            ),
          },
          if (_currentIndex == photos.length) ...{
            Positioned(
              top: _overlayOffset,
              left: _overlayOffset,
              child: _getOverlayChip(context, _getMapLabel(context)),
            ),
          },
          if (pagesCount > 1) ...{
            Positioned(
              right: _overlayOffset,
              bottom: _overlayOffset,
              child: _getOverlayChip(
                context,
                AppLocalizations.of(context)!.offerPhotoCounter(_currentIndex + 1, pagesCount),
              ),
            ),
          },
        ],
      ),
    );
  }

  Widget _getPhoto(OfferPhoto photo) {
    return Image.network(photo.url ?? "", fit: BoxFit.cover, errorBuilder: (_, _, _) => _getGeometry());
  }

  Widget _getGeometry() {
    return OfferThumbnail(
      geometry: widget.offerDetails.offer.previewGeojson,
      borderRadius: BorderRadius.zero,
      geometryPadding: _geometryPadding,
    );
  }

  String _getMapLabel(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final String area = OfferFormatters.formatAreaValue(localizations, widget.offerDetails.offer.totalArea);
    final int plotsCount = widget.offerDetails.plots.length;
    return plotsCount > 1 ? localizations.offerMapLabelMany(plotsCount, area) : area;
  }

  Widget _getTakenOnPlotBadge(BuildContext context, OfferPhoto photo) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final DateTime? takenAt = photo.takenAt ?? photo.uploadedAt;
    final String label = takenAt != null
        ? localizations.offerPhotoTakenOnPlotDate(OfferFormatters.formatDate(localizations, takenAt))
        : localizations.offerPhotoTakenOnPlot;

    return _getOverlayChip(context, label, icon: IconConstants.mapPin);
  }

  Widget _getOverlayChip(BuildContext context, String text, {IconData? icon}) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: StyleConstants.edgeInsetsH10V4,
      decoration: const BoxDecoration(
        color: ColorConstants.bgSurface,
        borderRadius: StyleConstants.radius100,
        boxShadow: StyleConstants.mapElementShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...{
            Icon(icon, size: _badgeIconSize, color: ColorConstants.textBrand),
          },
          Text(text, style: textTheme.caption12),
        ].withHorizontalElementsSpacing(4),
      ),
    );
  }
}
