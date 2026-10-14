import 'package:equatable/equatable.dart';

class PaginatedResponse<T> extends Equatable {
  final List<T> data;
  final int? nextPage;
  final int itemsCount;

  const PaginatedResponse({
    required this.data,
    required this.itemsCount,
    this.nextPage,
  });

  static int? getPageFromUrl(String? url) {
    if (url == null) return null;
    return int.tryParse(Uri.parse(url).queryParameters["page"] ?? "");
  }

  @override
  List<Object?> get props => [data, nextPage, itemsCount];
}
