enum OfferViewSource {
  search(apiValue: "search"),
  map(apiValue: "map"),
  notifications(apiValue: "notifications"),
  link(apiValue: "link"),
  other(apiValue: "other");

  final String apiValue;

  const OfferViewSource({required this.apiValue});
}
