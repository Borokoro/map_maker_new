abstract class JsonParser {
  static double? parseDecimal(Object? value) {
    if (value == null) return null;
    return double.tryParse(value.toString());
  }

  static DateTime? parseDate(Object? value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  static List<String> parseStringList(Object? value) {
    if (value == null) return const [];
    return (value as List<dynamic>).cast<String>();
  }

  static List<T> parseList<T>(Object? value, T Function(Map<String, dynamic> json) fromJson) {
    if (value == null) return const [];
    return (value as List<dynamic>).map((Object? item) => fromJson(item as Map<String, dynamic>)).toList();
  }

  static List<T> parseEnumList<T>(Object? value, T? Function(String apiValue) fromApiValue) {
    return parseStringList(value).map(fromApiValue).whereType<T>().toList();
  }
}
