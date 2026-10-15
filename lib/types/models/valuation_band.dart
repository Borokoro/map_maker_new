import 'package:equatable/equatable.dart';

class ValuationBand extends Equatable {
  final double low;
  final double likelyLow;
  final double median;
  final double likelyHigh;
  final double high;

  const ValuationBand({
    required this.low,
    required this.likelyLow,
    required this.median,
    required this.likelyHigh,
    required this.high,
  });

  factory ValuationBand.fromJson(Map<String, dynamic> json) {
    return ValuationBand(
      low: (json["low"] as num).toDouble(),
      likelyLow: (json["likely_low"] as num).toDouble(),
      median: (json["median"] as num).toDouble(),
      likelyHigh: (json["likely_high"] as num).toDouble(),
      high: (json["high"] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [low, likelyLow, median, likelyHigh, high];
}
