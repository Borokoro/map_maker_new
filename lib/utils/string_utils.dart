abstract class StringUtils {
  static const String _showLessSuffix = "Wyświetl mniej";

  static String removeShowLessSuffix(String text) {
    final String trimmedText = text.trim();
    if (!trimmedText.endsWith(_showLessSuffix)) return trimmedText;
    return trimmedText.substring(0, trimmedText.length - _showLessSuffix.length).trim();
  }
}
