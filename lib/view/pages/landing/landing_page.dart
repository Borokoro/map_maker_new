import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/router/app_router.gr.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

@RoutePage(name: "LandingRoute")
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const double _defaultNavigationMenuHeight = 76;
  static const double _sellIconSize = 34;
  static const double _sellPlusIconSize = 18;
  static const double _iconsSize = 22;

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      lazyLoad: false,
      resizeToAvoidBottomInset: false,
      routes: const [
        SearchRoute(),
        SavedRoute(),
        SellRoute(),
        MessagesRoute(),
        AccountRoute(),
      ],
      bottomNavigationBuilder: _getNavigationBar,
    );
  }

  Widget _getNavigationBar(BuildContext context, TabsRouter tabsRouter) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      height: _defaultNavigationMenuHeight,
      decoration: const BoxDecoration(border: StyleConstants.borderT1),
      child: BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: ColorConstants.bgSurface,
        selectedItemColor: ColorConstants.textBrand,
        unselectedItemColor: ColorConstants.textMuted,
        selectedLabelStyle: textTheme.caption12,
        unselectedLabelStyle: textTheme.caption12,
        items: [
          BottomNavigationBarItem(
            icon: _getNavigationIcon(
              IconConstants.search,
              ColorConstants.textMuted,
            ),
            activeIcon: _getNavigationIcon(
              IconConstants.search,
              ColorConstants.borderBrand,
            ),
            label: localizations.search,
          ),
          BottomNavigationBarItem(
            icon: _getNavigationIcon(
              IconConstants.saved,
              ColorConstants.textMuted,
            ),
            activeIcon: _getNavigationIcon(
              IconConstants.saved,
              ColorConstants.borderBrand,
            ),
            label: localizations.saved,
          ),
          BottomNavigationBarItem(
            icon: _getSellIcon(),
            label: localizations.sell,
          ),
          BottomNavigationBarItem(
            icon: _getNavigationIcon(
              IconConstants.messages,
              ColorConstants.textMuted,
            ),
            activeIcon: _getNavigationIcon(
              IconConstants.messages,
              ColorConstants.borderBrand,
            ),
            label: localizations.messages,
          ),
          BottomNavigationBarItem(
            icon: _getNavigationIcon(
              IconConstants.account,
              ColorConstants.textMuted,
            ),
            activeIcon: _getNavigationIcon(
              IconConstants.account,
              ColorConstants.borderBrand,
            ),
            label: localizations.account,
          ),
        ],
      ),
    );
  }

  Widget _getNavigationIcon(IconData icon, Color color) {
    return SizedBox(
      height: _sellIconSize,
      child: Icon(icon, color: color, size: _iconsSize),
    );
  }

  Widget _getSellIcon() {
    return Container(
      width: _sellIconSize,
      height: _sellIconSize,
      decoration: BoxDecoration(
        color: ColorConstants.bgBrand,
        borderRadius: StyleConstants.radius17,
      ),
      child: const Icon(
        IconConstants.plus,
        size: _sellPlusIconSize,
        color: ColorConstants.textOnBrand,
      ),
    );
  }
}
