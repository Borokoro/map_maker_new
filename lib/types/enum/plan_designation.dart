enum PlanDesignation {
  residential,
  residentialServices,
  farmstead,
  recreation,
  services,
  industrial,
  agricultural,
  forest,
  green,
  water,
  transport,
  infrastructure,
  cemetery,
  open,
  other;

  static PlanDesignation? fromApiValue(String? apiValue) {
    switch (apiValue) {
      case "residential":
        return PlanDesignation.residential;
      case "residential_services":
        return PlanDesignation.residentialServices;
      case "farmstead":
        return PlanDesignation.farmstead;
      case "recreation":
        return PlanDesignation.recreation;
      case "services":
        return PlanDesignation.services;
      case "industrial":
        return PlanDesignation.industrial;
      case "agricultural":
        return PlanDesignation.agricultural;
      case "forest":
        return PlanDesignation.forest;
      case "green":
        return PlanDesignation.green;
      case "water":
        return PlanDesignation.water;
      case "transport":
        return PlanDesignation.transport;
      case "infrastructure":
        return PlanDesignation.infrastructure;
      case "cemetery":
        return PlanDesignation.cemetery;
      case "open":
        return PlanDesignation.open;
      case "other":
        return PlanDesignation.other;
      default:
        return null;
    }
  }
}
