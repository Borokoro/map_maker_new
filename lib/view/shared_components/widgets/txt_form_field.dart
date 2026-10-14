import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/constants/style_constants.dart';
import 'package:map_maker_new/utils/text_theme_extension.dart';

class TxtFormField extends StatelessWidget {
  const TxtFormField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.autofillHints,
    this.onSubmitted,
    this.onChanged,
    this.errorText,
    this.helperText,
    this.enabled = true,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final Iterable<String>? autofillHints;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final String? errorText;
  final String? helperText;
  final bool enabled;

  static const int _messageMaxLines = 3;
  static const OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: StyleConstants.radius12,
    borderSide: BorderSide(color: ColorConstants.borderDefault),
  );
  static const OutlineInputBorder _focusedBorder = OutlineInputBorder(
    borderRadius: StyleConstants.radius12,
    borderSide: BorderSide(color: ColorConstants.borderBrand, width: 1.5),
  );
  static const OutlineInputBorder _errorBorder = OutlineInputBorder(
    borderRadius: StyleConstants.radius12,
    borderSide: BorderSide(color: ColorConstants.textDanger),
  );
  static const OutlineInputBorder _focusedErrorBorder = OutlineInputBorder(
    borderRadius: StyleConstants.radius12,
    borderSide: BorderSide(color: ColorConstants.textDanger, width: 1.5),
  );

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      enabled: enabled,
      style: textTheme.bodyBase16,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: textTheme.bodyBase16.copyWith(color: ColorConstants.textMuted),
        floatingLabelStyle: textTheme.caption12.copyWith(color: ColorConstants.textSecondary),
        errorText: errorText,
        errorStyle: textTheme.caption12.copyWith(color: ColorConstants.textDanger),
        errorMaxLines: _messageMaxLines,
        helperText: helperText,
        helperStyle: textTheme.caption12.copyWith(color: ColorConstants.textMuted),
        helperMaxLines: _messageMaxLines,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: ColorConstants.bgSurface,
        contentPadding: StyleConstants.edgeInsetsH16V14,
        border: _border,
        enabledBorder: _border,
        disabledBorder: _border,
        focusedBorder: _focusedBorder,
        errorBorder: _errorBorder,
        focusedErrorBorder: _focusedErrorBorder,
      ),
    );
  }
}
