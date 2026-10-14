import 'package:equatable/equatable.dart';

class OfferLocationCount extends Equatable {
  final String name;
  final int count;

  const OfferLocationCount({required this.name, required this.count});

  factory OfferLocationCount.fromJson(Map<String, dynamic> json) {
    return OfferLocationCount(
      name: json["name"] as String,
      count: json["count"] as int? ?? 0,
    );
  }

  @override
  List<Object?> get props => [name, count];
}
