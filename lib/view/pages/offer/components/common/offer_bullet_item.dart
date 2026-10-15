import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/types/custom_types/offer_bullet.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class OfferBulletItem extends StatelessWidget {
  const OfferBulletItem({super.key, required this.bullet});

  final OfferBullet bullet;

  static const double _iconSize = 18;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(bullet.icon, size: _iconSize, color: bullet.color),
        Expanded(
          child: Text(
            bullet.text,
            style: textTheme.bodySmall14.copyWith(color: ColorConstants.textSecondary, fontWeight: FontWeight.w400),
          ),
        ),
      ].withHorizontalElementsSpacing(8),
    );
  }
}
