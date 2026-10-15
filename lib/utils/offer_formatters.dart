import 'package:intl/intl.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';

abstract class OfferFormatters {
  static const int _thousand = 1000;
  static const int _million = 1000000;
  static const int _bytesInKilobyte = 1024;
  static const int _bytesInMegabyte = 1024 * 1024;
  static const int _metersInKilometer = 1000;

  static String? formatRange(AppLocalizations localizations, int? min, int? max, String Function(int) format) {
    if (min != null && max != null) return localizations.rangeBetween(format(min), format(max));
    if (max != null) return localizations.rangeUpTo(format(max));
    if (min != null) return localizations.rangeFrom(format(min));
    return null;
  }

  static String formatPrice(AppLocalizations localizations, int price) {
    if (price >= _million) {
      final NumberFormat millionsFormat = NumberFormat("0.#", localizations.localeName);
      return localizations.priceMillions(millionsFormat.format(price / _million));
    }
    return localizations.priceThousands((price / _thousand).round().toString());
  }

  static String formatArea(AppLocalizations localizations, int area) {
    final NumberFormat areaFormat = NumberFormat.decimalPattern(localizations.localeName);
    return localizations.areaSquareMeters(areaFormat.format(area));
  }

  static String formatFullPrice(AppLocalizations localizations, double price) {
    return localizations.offerPrice(NumberFormat.decimalPattern(localizations.localeName).format(price.round()));
  }

  static String formatPricePerMeter(AppLocalizations localizations, double pricePerMeter) {
    final NumberFormat numberFormat = NumberFormat.decimalPattern(localizations.localeName)..maximumFractionDigits = 1;
    return localizations.offerPricePerMeter(numberFormat.format(pricePerMeter));
  }

  static String formatAreaValue(AppLocalizations localizations, double? area) {
    return formatArea(localizations, (area ?? 0).round());
  }

  static String formatPriceRange(AppLocalizations localizations, double low, double high) {
    return localizations.rangeBetween(formatPrice(localizations, low.round()), formatPrice(localizations, high.round()));
  }

  static String formatPricePerMeterRange(AppLocalizations localizations, double low, double high) {
    return localizations.rangeBetween(formatPricePerMeter(localizations, low), formatPricePerMeter(localizations, high));
  }

  static String formatDistance(AppLocalizations localizations, double meters) {
    if (meters < _metersInKilometer) {
      return localizations.distanceMeters(meters.round().toString());
    }
    final NumberFormat numberFormat = NumberFormat.decimalPattern(localizations.localeName)..maximumFractionDigits = 1;
    return localizations.distanceKilometers(numberFormat.format(meters / _metersInKilometer));
  }

  static String? formatFileSize(AppLocalizations localizations, int? bytes) {
    if (bytes == null || bytes <= 0) return null;
    if (bytes < _bytesInMegabyte) {
      final int kilobytes = (bytes / _bytesInKilobyte).round();
      return localizations.fileSizeKb((kilobytes < 1 ? 1 : kilobytes).toString());
    }
    final NumberFormat numberFormat = NumberFormat.decimalPattern(localizations.localeName)..maximumFractionDigits = 1;
    return localizations.fileSizeMb(numberFormat.format(bytes / _bytesInMegabyte));
  }

  static String formatDate(AppLocalizations localizations, DateTime date) {
    return DateFormat.yMMMMd(localizations.localeName).format(date.toLocal());
  }

  static String formatMonthYear(AppLocalizations localizations, DateTime date) {
    return DateFormat("MMMM y", localizations.localeName).format(date.toLocal());
  }
}
