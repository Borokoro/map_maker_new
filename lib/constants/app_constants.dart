import 'package:map_maker_new/constants/env_constants.dart';

abstract class AppConstants {
  static const String defaultFont = "Inter";
  static const String termsUrl = "${EnvConstants.websiteUrl}/regulamin";
  static const String privacyPolicyUrl = "${EnvConstants.websiteUrl}/prywatnosc";
  static const String offersUrl = "${EnvConstants.websiteUrl}/oferty";
  static const int notFoundStatusCode = 404;
  static const String emailField = "email";
}
