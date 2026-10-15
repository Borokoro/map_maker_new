import 'package:equatable/equatable.dart';
import 'package:map_maker_new/types/enum/price_verdict.dart';
import 'package:map_maker_new/types/models/valuation_band.dart';

class OfferValuation extends Equatable {
  final ValuationBand total;
  final ValuationBand? perM2;
  final PriceVerdict? priceVerdict;

  const OfferValuation({required this.total, required this.perM2, required this.priceVerdict});

  factory OfferValuation.fromJson(Map<String, dynamic> json) {
    return OfferValuation(
      total: ValuationBand.fromJson(json["total"] as Map<String, dynamic>),
      perM2: json["per_m2"] == null ? null : ValuationBand.fromJson(json["per_m2"] as Map<String, dynamic>),
      priceVerdict: PriceVerdict.fromApiValue(json["price_verdict"] as String?),
    );
  }

  @override
  List<Object?> get props => [total, perM2, priceVerdict];
}
