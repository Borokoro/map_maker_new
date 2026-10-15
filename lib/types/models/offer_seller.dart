import 'package:equatable/equatable.dart';
import 'package:map_maker_new/utils/json_parser.dart';

class OfferSeller extends Equatable {
  final String id;
  final String firstName;
  final String? profilePhotoUrl;
  final DateTime? memberSince;

  const OfferSeller({
    required this.id,
    required this.firstName,
    required this.profilePhotoUrl,
    required this.memberSince,
  });

  factory OfferSeller.fromJson(Map<String, dynamic> json) {
    return OfferSeller(
      id: json["id"] as String? ?? "",
      firstName: json["first_name"] as String? ?? "",
      profilePhotoUrl: json["profile_photo_url"] as String?,
      memberSince: JsonParser.parseDate(json["member_since"]),
    );
  }

  @override
  List<Object?> get props => [id, firstName, profilePhotoUrl, memberSince];
}
