enum PlotUtilityStatus {
  available,
  atBoundary,
  inProgress,
  planned,
  notAvailable,
  listed,
  unknown;

  static PlotUtilityStatus fromApiValue(String? apiValue) {
    switch (apiValue) {
      case "available":
        return PlotUtilityStatus.available;
      case "at_boundary":
        return PlotUtilityStatus.atBoundary;
      case "in_progress":
        return PlotUtilityStatus.inProgress;
      case "planned":
        return PlotUtilityStatus.planned;
      default:
        return PlotUtilityStatus.notAvailable;
    }
  }

  bool get isAvailable => this == PlotUtilityStatus.available || this == PlotUtilityStatus.listed;

  bool get hasConnectionDeclaration => this == PlotUtilityStatus.available || this == PlotUtilityStatus.atBoundary;
}
