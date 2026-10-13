import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class FilterSection extends StatefulWidget {
  const FilterSection({
    super.key,
    required this.title,
    required this.appliedFiltersCount,
    required this.child,
  });

  final String title;
  final int appliedFiltersCount;
  final Widget child;

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: StyleConstants.borderB1),
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getHeader(context),
          if (_isExpanded) widget.child,
        ],
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Text(widget.title, style: textTheme.bodyBase16.copyWith(fontWeight: FontWeight.w600)),
            if (widget.appliedFiltersCount > 0) _getCountBadge(context),
            const Spacer(),
            Icon(
              _isExpanded ? IconConstants.chevronUp : IconConstants.chevronDown,
              color: ColorConstants.iconDefault,
            ),
          ].withHorizontalElementsSpacing(8),
        ),
      ),
    );
  }

  Widget _getCountBadge(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: const BoxDecoration(
        color: ColorConstants.bgBrandSoft,
        borderRadius: StyleConstants.radius100,
      ),
      child: Text(
        widget.appliedFiltersCount.toString(),
        style: textTheme.caption12.copyWith(color: ColorConstants.textBrand),
      ),
    );
  }
}
