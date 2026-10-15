import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/models/offer_details.dart';
import 'package:map_maker_new/types/models/offer_seller.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';
import 'package:map_maker_new/view/pages/offer/components/common/offer_card_container.dart';
import 'package:map_maker_new/utils/offer_formatters.dart';

class OfferSellerSection extends StatelessWidget {
  const OfferSellerSection({super.key, required this.offerDetails});

  final OfferDetails offerDetails;

  static const double _avatarRadius = 24;
  static const int _initialsCount = 2;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final OfferSeller seller = offerDetails.seller;
    final String name = seller.firstName.trim().isNotEmpty
        ? seller.firstName.trim()
        : localizations.offerSellerFallbackName;
    final DateTime? memberSince = seller.memberSince;
    final DateTime? publishedAt = offerDetails.offer.publishedAt;
    final TextStyle metaStyle = textTheme.caption12.copyWith(color: ColorConstants.textMuted);

    return OfferCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _getAvatar(context, seller, name),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: textTheme.bodyLarge18.copyWith(fontWeight: FontWeight.w600)),
                    if (memberSince != null) ...{
                      Text(
                        localizations.offerSellerMemberSince(OfferFormatters.formatMonthYear(localizations, memberSince)),
                        style: metaStyle,
                      ),
                    },
                  ].withVerticalElementsSpacing(2),
                ),
              ),
            ].withHorizontalElementsSpacing(12),
          ),
          if (publishedAt != null) ...{
            Text(localizations.offerSellerAdded(OfferFormatters.formatDate(localizations, publishedAt)), style: metaStyle),
          },
        ].withVerticalElementsSpacing(12),
      ),
    );
  }

  Widget _getAvatar(BuildContext context, OfferSeller seller, String name) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String? photoUrl = seller.profilePhotoUrl;

    return CircleAvatar(
      radius: _avatarRadius,
      backgroundColor: ColorConstants.bgBrandSoft,
      foregroundImage: photoUrl != null && photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
      child: Text(_getInitials(name), style: textTheme.bodySmall14.copyWith(color: ColorConstants.textBrand)),
    );
  }

  String _getInitials(String name) {
    return name
        .split(RegExp(r"\s+"))
        .where((String part) => part.isNotEmpty)
        .take(_initialsCount)
        .map((String part) => part.characters.first.toUpperCase())
        .join();
  }
}
