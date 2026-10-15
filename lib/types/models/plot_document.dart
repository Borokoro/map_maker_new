import 'package:equatable/equatable.dart';

class PlotDocument extends Equatable {
  final String documentId;
  final String documentType;
  final String title;
  final int? documentSize;
  final String? fileExtension;
  final bool isVerified;

  const PlotDocument({
    required this.documentId,
    required this.documentType,
    required this.title,
    required this.documentSize,
    required this.fileExtension,
    required this.isVerified,
  });

  factory PlotDocument.fromJson(Map<String, dynamic> json) {
    return PlotDocument(
      documentId: json["document_id"] as String,
      documentType: json["document_type"] as String? ?? "",
      title: json["title"] as String? ?? "",
      documentSize: json["document_size"] as int?,
      fileExtension: json["file_extension"] as String?,
      isVerified: json["is_verified"] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [documentId, documentType, title, documentSize, fileExtension, isVerified];
}
