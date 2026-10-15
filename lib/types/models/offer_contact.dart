import 'package:equatable/equatable.dart';

class OfferContact extends Equatable {
  final String phone;
  final String email;

  const OfferContact({required this.phone, required this.email});

  factory OfferContact.fromJson(Map<String, dynamic> json) {
    return OfferContact(phone: json["phone"] as String? ?? "", email: json["email"] as String? ?? "");
  }

  @override
  List<Object?> get props => [phone, email];
}
