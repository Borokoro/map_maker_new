import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    required this.query,
    required this.onSearchSubmitted,
  });

  final String? query;
  final void Function(String) onSearchSubmitted;

  static const double _height = 48;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final TextEditingController _controller = TextEditingController(text: widget.query);

  static const double _iconSize = 20;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      height: SearchBarWidget._height,
      decoration: const BoxDecoration(
        color: ColorConstants.bgSurface,
        borderRadius: StyleConstants.radius100,
        boxShadow: StyleConstants.mapElementShadow,
      ),
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.search,
        style: textTheme.bodyBase16,
        onSubmitted: _onSubmitted,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          hintText: localizations.searchPlaceholder,
          hintStyle: textTheme.bodyBase16.copyWith(color: ColorConstants.textMuted),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          prefixIcon: const Icon(IconConstants.search, color: ColorConstants.iconDefault, size: _iconSize),
          suffixIcon: _getClearButton(),
        ),
      ),
    );
  }

  Widget _getClearButton() {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (BuildContext context, TextEditingValue value, _) {
        if (value.text.isEmpty) return const SizedBox.shrink();
        return IconButton(
          tooltip: AppLocalizations.of(context)!.clear,
          onPressed: _onClear,
          icon: const Icon(IconConstants.close, color: ColorConstants.iconDefault, size: _iconSize),
        );
      },
    );
  }

  void _onSubmitted(String query) {
    widget.onSearchSubmitted(query);
  }

  void _onClear() {
    _controller.clear();
    if (widget.query != null) widget.onSearchSubmitted("");
  }
}
