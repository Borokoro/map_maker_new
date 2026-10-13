enum OfferDesignation {
  residential(apiValue: "residential"),
  residentialServices(apiValue: "residential_services"),
  farmstead(apiValue: "farmstead"),
  recreation(apiValue: "recreation"),
  services(apiValue: "services"),
  industrial(apiValue: "industrial"),
  agricultural(apiValue: "agricultural"),
  forest(apiValue: "forest"),
  open(apiValue: "open");

  final String apiValue;

  const OfferDesignation({required this.apiValue});
}
