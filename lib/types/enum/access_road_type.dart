enum AccessRoadType {
  asphalt,
  gravel,
  dirt,
  easement;

  static AccessRoadType? fromApiValue(String? apiValue) {
    switch (apiValue) {
      case "asphalt":
        return AccessRoadType.asphalt;
      case "gravel":
        return AccessRoadType.gravel;
      case "dirt":
        return AccessRoadType.dirt;
      case "easement":
        return AccessRoadType.easement;
      default:
        return null;
    }
  }

  bool get isPaved => this == AccessRoadType.asphalt || this == AccessRoadType.gravel;
}
