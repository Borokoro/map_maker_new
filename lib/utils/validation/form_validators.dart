import 'package:map_maker_new/l10n/app_localizations.dart';

abstract class FormValidators {
  static const int passwordMinLength = 8;
  static final RegExp _emailRegExp = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");

  static String? Function(String?) requiredValidator(AppLocalizations localizations) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) return localizations.fieldRequired;
      return null;
    };
  }

  static String? Function(String?) emailValidator(AppLocalizations localizations) {
    return (String? value) {
      final String? requiredError = requiredValidator(localizations)(value);
      if (requiredError != null) return requiredError;
      if (!_emailRegExp.hasMatch(value!.trim())) return localizations.invalidEmail;
      return null;
    };
  }

  static String? Function(String?) passwordValidator(AppLocalizations localizations) {
    return (String? value) {
      if (value == null || value.isEmpty) return localizations.fieldRequired;
      if (value.length < passwordMinLength) return localizations.passwordTooShort(passwordMinLength);
      return null;
    };
  }
}
