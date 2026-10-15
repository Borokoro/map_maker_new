enum UtilitySource {
  owner,
  detected;

  static UtilitySource? fromApiValue(String? apiValue) {
    switch (apiValue) {
      case "owner":
        return UtilitySource.owner;
      case "detected":
        return UtilitySource.detected;
      default:
        return null;
    }
  }
}
