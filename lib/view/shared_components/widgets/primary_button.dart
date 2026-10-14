import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  static const double height = 48;
  static const double _loaderSize = 20;
  static const double _loaderStrokeWidth = 2;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: ColorConstants.bgBrand,
        disabledBackgroundColor: ColorConstants.bgBrand,
        foregroundColor: ColorConstants.textOnBrand,
        minimumSize: const Size.fromHeight(height),
        shape: const RoundedRectangleBorder(borderRadius: StyleConstants.radius100),
      ),
      child: isLoading ? _getLoader() : Text(text),
    );
  }

  Widget _getLoader() {
    return const SizedBox.square(
      dimension: _loaderSize,
      child: CircularProgressIndicator(
        color: ColorConstants.textOnBrand,
        strokeWidth: _loaderStrokeWidth,
      ),
    );
  }
}
