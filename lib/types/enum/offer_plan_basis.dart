enum OfferPlanBasis {
  mpzp(apiValue: "mpzp"),
  pog(apiValue: "pog"),
  wz(apiValue: "wz"),
  pogDraft(apiValue: "pog_draft"),
  studium(apiValue: "studium"),
  none(apiValue: "none");

  final String apiValue;

  const OfferPlanBasis({required this.apiValue});
}
