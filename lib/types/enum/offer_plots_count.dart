enum OfferPlotsCount {
  one(apiValue: "1"),
  many(apiValue: "2plus");

  final String apiValue;

  const OfferPlotsCount({required this.apiValue});
}
