import 'package:equatable/equatable.dart';

class OfferEstimate extends Equatable {
  final double low;
  final double median;
  final double high;
  final String? confidence;

  const OfferEstimate({
    required this.low,
    required this.median,
    required this.high,
    required this.confidence,
  });

  factory OfferEstimate.fromJson(Map<String, dynamic> json) {
    return OfferEstimate(
      low: (json["low"] as num).toDouble(),
      median: (json["median"] as num).toDouble(),
      high: (json["high"] as num).toDouble(),
      confidence: json["confidence"] as String?,
    );
  }

  @override
  List<Object?> get props => [low, median, high, confidence];
}