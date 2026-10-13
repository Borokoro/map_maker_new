enum OfferUtility {
  electricity(apiValue: "electricity"),
  water(apiValue: "water"),
  sewage(apiValue: "sewage"),
  gas(apiValue: "gas"),
  internet(apiValue: "internet");

  final String apiValue;

  const OfferUtility({required this.apiValue});
}
