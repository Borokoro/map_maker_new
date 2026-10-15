enum OwnershipType {
  full,
  perpetualUsufruct,
  share;

  static OwnershipType? fromApiValue(String? apiValue) {
    switch (apiValue) {
      case "full":
        return OwnershipType.full;
      case "perpetual_usufruct":
        return OwnershipType.perpetualUsufruct;
      case "share":
        return OwnershipType.share;
      default:
        return null;
    }
  }
}
