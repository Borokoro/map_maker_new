enum PlanDesignation {
  residential(apiValue: "residential"),
  residentialServices(apiValue: "residential_services"),
  farmstead(apiValue: "farmstead"),
  recreation(apiValue: "recreation"),
  services(apiValue: "services"),
  industrial(apiValue: "industrial"),
  agricultural(apiValue: "agricultural"),
  forest(apiValue: "forest"),
  green(apiValue: "green"),
  water(apiValue: "water"),
  transport(apiValue: "transport"),
  infrastructure(apiValue: "infrastructure"),
  cemetery(apiValue: "cemetery"),
  open(apiValue: "open"),
  other(apiValue: "other");

  final String apiValue;

  const PlanDesignation({required this.apiValue});

  static PlanDesignation? fromApiValue(String? apiValue) {
    for (final PlanDesignation designation in PlanDesignation.values) {
      if (designation.apiValue == apiValue) return designation;
    }
    return null;
  }
}
