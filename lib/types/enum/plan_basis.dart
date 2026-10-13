enum PlanBasis {
  unknown(apiValue: "unknown"),
  mpzp(apiValue: "mpzp"),
  mpzpUnreadable(apiValue: "mpzp_unreadable"),
  pog(apiValue: "pog"),
  wz(apiValue: "wz"),
  pogDraft(apiValue: "pog_draft"),
  studium(apiValue: "studium"),
  none(apiValue: "none"),
  mixed(apiValue: "mixed");

  final String apiValue;

  const PlanBasis({required this.apiValue});

  static PlanBasis fromApiValue(String? apiValue) {
    return PlanBasis.values.firstWhere(
      (planBasis) => planBasis.apiValue == apiValue,
      orElse: () => PlanBasis.unknown,
    );
  }
}
