import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.text, required this.onPressed, this.icon, this.isLoading = false});

  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  static const double _height = 48;
  static const double _iconSize = 18;
  static const double _loaderSize = 20;
  static const double _loaderStrokeWidth = 2;

  @override
  Widget build(BuildContext context) {
    final IconData? buttonIcon = icon;

    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorConstants.textPrimary,
        minimumSize: const Size.fromHeight(_height),
        side: const BorderSide(color: ColorConstants.borderStrong),
        shape: const RoundedRectangleBorder(borderRadius: StyleConstants.radius100),
      ),
      icon: isLoading
          ? _getLoader()
          : buttonIcon != null
          ? Icon(buttonIcon, size: _iconSize)
          : null,
      label: Text(text, textAlign: TextAlign.center),
    );
  }

  Widget _getLoader() {
    return const SizedBox.square(
      dimension: _loaderSize,
      child: CircularProgressIndicator(color: ColorConstants.bgBrand, strokeWidth: _loaderStrokeWidth),
    );
  }
}
