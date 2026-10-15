enum DocumentType {
  landRegisterExtract,
  zoningExtract,
  surveyMap,
  zoningDecision,
  connectionAcceptance;

  static DocumentType? fromApiValue(String? apiValue) {
    switch (apiValue) {
      case "land_register_extract":
        return DocumentType.landRegisterExtract;
      case "zoning_extract":
        return DocumentType.zoningExtract;
      case "survey_map":
        return DocumentType.surveyMap;
      case "zoning_decision":
        return DocumentType.zoningDecision;
      case "connection_acceptance":
        return DocumentType.connectionAcceptance;
      default:
        return null;
    }
  }
}
