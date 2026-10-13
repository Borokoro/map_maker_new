import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class FilterChoiceChip extends StatelessWidget {
  const FilterChoiceChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final void Function() onTap;

  static const double _iconSize = 16;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Color contentColor = isSelected ? ColorConstants.textBrand : ColorConstants.textSecondary;

    return ChoiceChip(
      backgroundColor: ColorConstants.bgSurface,
      selectedColor: ColorConstants.bgBrandSoft,
      avatar: Icon(
        isSelected ? IconConstants.check : IconConstants.add,
        size: _iconSize,
        color: contentColor,
      ),
      label: Text(label),
      labelStyle: textTheme.bodySmall14.copyWith(color: contentColor),
      selected: isSelected,
      shape: const RoundedRectangleBorder(borderRadius: StyleConstants.radius100),
      side: BorderSide(
        color: isSelected ? ColorConstants.borderBrand : ColorConstants.borderDefault,
      ),
      onSelected: (_) => onTap(),
      pressElevation: 0,
      showCheckmark: false,
    );
  }
}
