enum EncumbranceType {
  mortgage,
  easement,
  other;

  static EncumbranceType? fromApiValue(String? apiValue) {
    switch (apiValue) {
      case "mortgage":
        return EncumbranceType.mortgage;
      case "easement":
        return EncumbranceType.easement;
      case "other":
        return EncumbranceType.other;
      default:
        return null;
    }
  }
}
