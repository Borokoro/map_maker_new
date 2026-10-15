enum PlanType {
  mpzp,
  pog,
  pogDraft,
  studium,
  wz,
  none;

  static PlanType? fromApiValue(String? apiValue) {
    switch (apiValue) {
      case "mpzp":
        return PlanType.mpzp;
      case "pog":
        return PlanType.pog;
      case "pog_draft":
        return PlanType.pogDraft;
      case "studium":
        return PlanType.studium;
      case "wz":
        return PlanType.wz;
      case "none":
        return PlanType.none;
      default:
        return null;
    }
  }
}
