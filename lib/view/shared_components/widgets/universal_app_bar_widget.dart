import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_maker_new/app_config.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/constants/svg_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/utils/elements_spacing_extension.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class UniversalAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const UniversalAppBarWidget({super.key});

  static const double _appBarHeight = 64;
  static const double _iconSize = 22;
  static const Color _iconColor = ColorConstants.textSecondary;

  @override
  Size get preferredSize => const Size.fromHeight(_appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: _appBarHeight,
      backgroundColor: ColorConstants.bgSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      titleSpacing: 0,
      shape: StyleConstants.borderB1,
      title: Padding(
        padding: StyleConstants.edgeInsetsH20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getTitleAndIconWidgetWidget(context),
            if (AppConfig.shouldShowButtonsOnAppBar) ...{_getButtons()},
          ],
        ),
      ),
    );
  }

  Widget _getTitleAndIconWidgetWidget(BuildContext context) {
    return Row(
      children: [
        _getIconWidget(),
        _getTitleWidget(context),
      ].withHorizontalElementsSpacing(10),
    );
  }

  Widget _getIconWidget() {
    return SvgPicture.asset(SvgConstants.logo);
  }

  Widget _getTitleWidget(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Text(localizations.plotFinder, style: textTheme.headingH4_20);
  }

  Widget _getButtons() {
    return Row(
      children: [
        _getSearchButton(),
        _getMenuButton(),
      ].withHorizontalElementsSpacing(18),
    );
  }

  Widget _getSearchButton() {
    return InkWell(
      onTap: () {},
      child: Icon(IconConstants.search, color: _iconColor, size: _iconSize),
    );
  }

  Widget _getMenuButton() {
    return InkWell(
      onTap: () {},
      child: Icon(IconConstants.menu, color: _iconColor, size: _iconSize),
    );
  }
}
