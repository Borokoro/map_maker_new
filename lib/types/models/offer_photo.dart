import 'package:equatable/equatable.dart';
import 'package:map_maker_new/utils/json_parser.dart';

class OfferPhoto extends Equatable {
  final String photoId;
  final String? url;
  final bool takenOnPlot;
  final DateTime? takenAt;
  final DateTime? uploadedAt;

  const OfferPhoto({
    required this.photoId,
    required this.url,
    required this.takenOnPlot,
    required this.takenAt,
    required this.uploadedAt,
  });

  factory OfferPhoto.fromJson(Map<String, dynamic> json) {
    return OfferPhoto(
      photoId: json["photo_id"] as String,
      url: json["url"] as String?,
      takenOnPlot: json["taken_on_plot"] as bool? ?? false,
      takenAt: JsonParser.parseDate(json["taken_at"]),
      uploadedAt: JsonParser.parseDate(json["uploaded_at"]),
    );
  }

  @override
  List<Object?> get props => [photoId, url, takenOnPlot, takenAt, uploadedAt];
}
