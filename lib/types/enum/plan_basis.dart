enum PlanBasis {
  unknown,
  mpzp,
  mpzpUnreadable,
  pog,
  wz,
  pogDraft,
  studium,
  none,
  mixed;

  static PlanBasis fromApiValue(String? apiValue) {
    switch (apiValue) {
      case "mpzp":
        return PlanBasis.mpzp;
      case "mpzp_unreadable":
        return PlanBasis.mpzpUnreadable;
      case "pog":
        return PlanBasis.pog;
      case "wz":
        return PlanBasis.wz;
      case "pog_draft":
        return PlanBasis.pogDraft;
      case "studium":
        return PlanBasis.studium;
      case "none":
        return PlanBasis.none;
      case "mixed":
        return PlanBasis.mixed;
      default:
        return PlanBasis.unknown;
    }
  }
}
