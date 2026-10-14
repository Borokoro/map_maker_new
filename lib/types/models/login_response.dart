import 'package:equatable/equatable.dart';
import 'package:map_maker_new/types/models/auth_tokens.dart';
import 'package:map_maker_new/types/models/auth_user.dart';

class LoginResponse extends Equatable {
  final AuthUser user;
  final AuthTokens tokens;

  const LoginResponse({required this.user, required this.tokens});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: AuthUser.fromJson(json["user"] as Map<String, dynamic>),
      tokens: AuthTokens.fromJson(json),
    );
  }

  @override
  List<Object?> get props => [user, tokens];
}
