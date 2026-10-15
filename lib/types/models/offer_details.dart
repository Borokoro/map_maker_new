import 'package:equatable/equatable.dart';
import 'package:map_maker_new/types/models/offer.dart';
import 'package:map_maker_new/types/models/offer_photo.dart';
import 'package:map_maker_new/types/models/offer_plot.dart';
import 'package:map_maker_new/types/models/offer_seller.dart';
import 'package:map_maker_new/types/models/offer_valuation.dart';
import 'package:map_maker_new/utils/json_parser.dart';
import 'package:map_maker_new/utils/string_utils.dart';

class OfferDetails extends Equatable {
  final Offer offer;
  final String description;
  final bool soldSeparately;
  final bool allowMessages;
  final bool hasPhone;
  final bool hasEmail;
  final String sourceUrl;
  final OfferValuation? valuation;
  final List<OfferPlot> plots;
  final List<OfferPhoto> photos;
  final OfferSeller seller;

  const OfferDetails({
    required this.offer,
    required this.description,
    required this.soldSeparately,
    required this.allowMessages,
    required this.hasPhone,
    required this.hasEmail,
    required this.sourceUrl,
    required this.valuation,
    required this.plots,
    required this.photos,
    required this.seller,
  });

  factory OfferDetails.fromJson(Map<String, dynamic> json) {
    return OfferDetails(
      offer: Offer.fromJson(json),
      description: StringUtils.removeShowLessSuffix(json["description"] as String? ?? ""),
      soldSeparately: json["sold_separately"] as bool? ?? false,
      allowMessages: json["allow_messages"] as bool? ?? true,
      hasPhone: json["has_phone"] as bool? ?? false,
      hasEmail: json["has_email"] as bool? ?? false,
      sourceUrl: json["source_url"] as String? ?? "",
      valuation: json["valuation"] == null ? null : OfferValuation.fromJson(json["valuation"] as Map<String, dynamic>),
      plots: JsonParser.parseList(json["plots"], OfferPlot.fromJson),
      photos: JsonParser.parseList(json["photos"], OfferPhoto.fromJson),
      seller: OfferSeller.fromJson(json["seller"] as Map<String, dynamic>? ?? const {}),
    );
  }

  OfferDetails copyWith({bool? isSaved}) {
    return OfferDetails(
      offer: offer.copyWith(isSaved: isSaved),
      description: description,
      soldSeparately: soldSeparately,
      allowMessages: allowMessages,
      hasPhone: hasPhone,
      hasEmail: hasEmail,
      sourceUrl: sourceUrl,
      valuation: valuation,
      plots: plots,
      photos: photos,
      seller: seller,
    );
  }

  @override
  List<Object?> get props => [
    offer,
    description,
    soldSeparately,
    allowMessages,
    hasPhone,
    hasEmail,
    sourceUrl,
    valuation,
    plots,
    photos,
    seller,
  ];
}
