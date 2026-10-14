import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String id;
  final String username;
  final String? email;
  final String? firstName;
  final String? lastName;

  const AuthUser({
    required this.id,
    required this.username,
    this.email,
    this.firstName,
    this.lastName,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json["id"].toString(),
      username: json["username"] as String,
      email: json["email"] as String?,
      firstName: json["first_name"] as String?,
      lastName: json["last_name"] as String?,
    );
  }

  @override
  List<Object?> get props => [id, username, email, firstName, lastName];
}
