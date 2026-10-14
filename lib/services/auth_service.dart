import 'dart:io';

import 'package:dio/dio.dart';
import 'package:map_maker_new/services/token_storage.dart';
import 'package:map_maker_new/types/models/auth_tokens.dart';
import 'package:map_maker_new/types/models/auth_user.dart';
import 'package:map_maker_new/types/models/login_response.dart';

class AuthService {
  static const String _apiBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const String _loginUrl = "$_apiBaseUrl/api/auth/login/";
  static const String _registerUrl = "$_apiBaseUrl/api/auth/register/";
  static const String _refreshUrl = "$_apiBaseUrl/api/auth/token/refresh/";
  static const String _logoutUrl = "$_apiBaseUrl/api/auth/logout/";
  static const String _passwordResetUrl = "$_apiBaseUrl/api/auth/password-reset/";

  final Dio dio;
  final TokenStorage tokenStorage;

  AuthService({required this.dio, required this.tokenStorage});

  bool get isLoggedIn => tokenStorage.hasTokens;

  Future<bool> restoreSession() async {
    final AuthTokens? tokens = await tokenStorage.restoreTokens();
    return tokens != null;
  }

  Future<AuthUser> login({required String identifier, required String password}) async {
    final Response<Map<String, dynamic>> response = await dio.post(
      _loginUrl,
      data: {
        "username": identifier.trim(),
        "password": password,
      },
    );
    final LoginResponse loginResponse = LoginResponse.fromJson(_getData(response));
    await tokenStorage.saveTokens(loginResponse.tokens);
    return loginResponse.user;
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
    String? firstName,
    String? lastName,
  }) async {
    await dio.post(
      _registerUrl,
      data: {
        "username": username.trim(),
        "email": email.trim(),
        "password": password,
        "first_name": ?firstName?.trim(),
        "last_name": ?lastName?.trim(),
      },
    );
  }

  Future<AuthTokens> refreshTokens() async {
    final String? refreshToken = tokenStorage.refreshToken;
    if (refreshToken == null) {
      throw StateError("Missing refresh token");
    }
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        _refreshUrl,
        data: {"refresh": refreshToken},
      );
      final AuthTokens tokens = AuthTokens.fromJson(
        _getData(response),
        currentRefresh: refreshToken,
      );
      await tokenStorage.saveTokens(tokens);
      return tokens;
    } on DioException catch (e) {
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        await tokenStorage.clearTokens();
      }
      rethrow;
    }
  }

  Future<void> logout() async {
    final AuthTokens? tokens = tokenStorage.tokens;
    if (tokens == null) return;
    try {
      await dio.post(
        _logoutUrl,
        data: {"refresh": tokens.refresh},
        options: Options(
          headers: {HttpHeaders.authorizationHeader: "Bearer ${tokens.access}"},
        ),
      );
    } on DioException catch (_) {
    } finally {
      await tokenStorage.clearTokens();
    }
  }

  Future<void> requestPasswordReset(String email) async {
    await dio.post(_passwordResetUrl, data: {"email": email.trim()});
  }

  Map<String, dynamic> _getData(Response<Map<String, dynamic>> response) {
    return response.data!["data"] as Map<String, dynamic>;
  }
}
