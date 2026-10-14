import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/enum/offer_utility.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/offer_filters_labels_extension.dart';
import 'package:map_maker_new/utils/offer_utility_icon_extension.dart';

class OfferUtilitiesWidget extends StatelessWidget {
  const OfferUtilitiesWidget({super.key, required this.availableUtilities});

  final List<String> availableUtilities;

  static const List<OfferUtility> _cardUtilities = [
    OfferUtility.electricity,
    OfferUtility.water,
    OfferUtility.gas,
    OfferUtility.sewage,
  ];
  static const double _dotSize = 26;
  static const double _iconSize = 14;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _cardUtilities
          .map((OfferUtility utility) => _getUtilityDot(context, utility))
          .toList()
          .withHorizontalElementsSpacing(4),
    );
  }

  Widget _getUtilityDot(BuildContext context, OfferUtility utility) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final bool isAvailable = availableUtilities.contains(utility.apiValue);
    final String name = utility.label(localizations);

    return Tooltip(
      message: isAvailable ? localizations.utilityAvailable(name) : localizations.utilityUnavailable(name),
      child: Container(
        width: _dotSize,
        height: _dotSize,
        decoration: BoxDecoration(
          color: isAvailable ? ColorConstants.bgSuccessSoft : ColorConstants.bgSurfaceAlt,
          shape: BoxShape.circle,
        ),
        child: Icon(
          utility.icon,
          size: _iconSize,
          color: isAvailable ? ColorConstants.textSuccess : ColorConstants.textMuted,
        ),
      ),
    );
  }
}
