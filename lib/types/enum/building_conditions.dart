enum BuildingConditions {
  none,
  zoningDecision,
  buildingPermit;

  static BuildingConditions? fromApiValue(String? apiValue) {
    switch (apiValue) {
      case "none":
        return BuildingConditions.none;
      case "zoning_decision":
        return BuildingConditions.zoningDecision;
      case "building_permit":
        return BuildingConditions.buildingPermit;
      default:
        return null;
    }
  }
}
