import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:map_maker_new/types/models/auth_tokens.dart';

class TokenStorage {
  static const String _accessTokenKey = "access_token";
  static const String _refreshTokenKey = "refresh_token";

  static const FlutterSecureStorage _defaultSecureStorage = FlutterSecureStorage(
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device),
  );

  final FlutterSecureStorage _secureStorage;
  AuthTokens? _tokens;

  TokenStorage([this._secureStorage = _defaultSecureStorage]);

  AuthTokens? get tokens => _tokens;
  String? get accessToken => _tokens?.access;
  String? get refreshToken => _tokens?.refresh;
  bool get hasTokens => _tokens != null;

  Future<AuthTokens?> restoreTokens() async {
    try {
      final String? access = await _secureStorage.read(key: _accessTokenKey);
      final String? refresh = await _secureStorage.read(key: _refreshTokenKey);
      _tokens = access != null && refresh != null
          ? AuthTokens(access: access, refresh: refresh)
          : null;
    } on PlatformException {
      await clearTokens();
    }
    return _tokens;
  }

  Future<void> saveTokens(AuthTokens tokens) async {
    _tokens = tokens;
    await _secureStorage.write(key: _accessTokenKey, value: tokens.access);
    await _secureStorage.write(key: _refreshTokenKey, value: tokens.refresh);
  }

  Future<void> clearTokens() async {
    _tokens = null;
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }
}
