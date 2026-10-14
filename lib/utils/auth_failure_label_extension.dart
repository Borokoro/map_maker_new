import 'package:map_maker_new/l10n/app_localizations.dart';
import 'package:map_maker_new/types/enum/auth_failure_type.dart';

extension AuthFailureLabelExtension on AuthFailureType {
  String label(AppLocalizations localizations) {
    switch (this) {
      case AuthFailureType.invalidCredentials:
        return localizations.loginInvalidCredentials;
      case AuthFailureType.invalidData:
        return localizations.invalidDataError;
      case AuthFailureType.tooManyRequests:
        return localizations.tooManyRequestsError;
      case AuthFailureType.network:
        return localizations.networkError;
      case AuthFailureType.unknown:
        return localizations.unknownError;
    }
  }
}
