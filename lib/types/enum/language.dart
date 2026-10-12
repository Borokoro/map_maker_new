enum Language {
  pl(langCode: "pl", countryCode: "pl_PL", locale: "PL");

  final String langCode;
  final String countryCode;
  final String locale;

  const Language({required this.langCode, required this.countryCode, required this.locale});

  static Language fromLangCode(String langCode) {
    return Language.values.firstWhere((lang) => lang.langCode == langCode);
  }
}
