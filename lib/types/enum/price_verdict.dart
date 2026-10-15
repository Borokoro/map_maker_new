enum PriceVerdict {
  below,
  market,
  above;

  static PriceVerdict? fromApiValue(String? apiValue) {
    switch (apiValue) {
      case "below":
        return PriceVerdict.below;
      case "market":
        return PriceVerdict.market;
      case "above":
        return PriceVerdict.above;
      default:
        return null;
    }
  }
}
