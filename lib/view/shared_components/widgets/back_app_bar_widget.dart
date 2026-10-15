import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class BackAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const BackAppBarWidget({super.key, this.title, this.actions});

  final String? title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final String? title = this.title;

    return AppBar(
      backgroundColor: ColorConstants.bgSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      shape: StyleConstants.borderB1,
      title: title != null ? Text(title, style: Theme.of(context).textTheme.headingH4_20) : null,
      leading: IconButton(
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        onPressed: () => AutoRouter.of(context).maybePop(),
        icon: const Icon(IconConstants.back, color: ColorConstants.textPrimary),
      ),
      actions: actions,
    );
  }
}
