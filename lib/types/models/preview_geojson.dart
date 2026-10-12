import 'package:equatable/equatable.dart';

class PreviewGeojson extends Equatable {
  final String type;
  final List<List<List<List<double>>>> coordinates;

  const PreviewGeojson({required this.type, required this.coordinates});

  factory PreviewGeojson.fromJson(Map<String, dynamic> json) {
    return PreviewGeojson(
      type: json["type"] as String,
      coordinates: (json["coordinates"] as List<dynamic>)
          .map(
            (polygon) => (polygon as List<dynamic>)
                .map(
                  (ring) => (ring as List<dynamic>)
                      .map(
                        (point) => (point as List<dynamic>)
                            .map((value) => (value as num).toDouble())
                            .toList(),
                      )
                      .toList(),
                )
                .toList(),
          )
          .toList(),
    );
  }

  @override
  List<Object?> get props => [type, coordinates];
}
