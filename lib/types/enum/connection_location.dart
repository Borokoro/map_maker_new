enum ConnectionLocation {
  onPlot,
  atBoundary,
  publicRoad,
  privateRoad;

  static ConnectionLocation? fromApiValue(String? apiValue) {
    switch (apiValue) {
      case "on_plot":
        return ConnectionLocation.onPlot;
      case "at_boundary":
        return ConnectionLocation.atBoundary;
      case "public_road":
        return ConnectionLocation.publicRoad;
      case "private_road":
        return ConnectionLocation.privateRoad;
      default:
        return null;
    }
  }
}
