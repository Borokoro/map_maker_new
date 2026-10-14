import 'dart:io';

import 'package:dio/dio.dart';
import 'package:map_maker_new/constants/env_constants.dart';
import 'package:map_maker_new/cubits/auth/auth_cubit.dart';
import 'package:map_maker_new/service_locator.dart';
import 'package:map_maker_new/services/auth_service.dart';
import 'package:map_maker_new/services/token_storage.dart';
import 'package:map_maker_new/types/models/auth_tokens.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._dio);

  static const String skipAuthKey = "skipAuth";
  static const String _retriedKey = "authRetried";
  static final Uri _apiUri = Uri.parse(EnvConstants.apiBaseUrl);

  final Dio _dio;
  Future<String?>? _refreshRequest;

  TokenStorage get _tokenStorage => serviceLocator.get<TokenStorage>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? accessToken = _tokenStorage.accessToken;
    if (accessToken != null && options.extra[skipAuthKey] != true && _isApiRequest(options)) {
      options.headers[HttpHeaders.authorizationHeader] = _getBearer(accessToken);
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final RequestOptions options = err.requestOptions;
    if (!_shouldRefresh(err)) return handler.next(err);
    try {
      final String? accessToken = await _getValidAccessToken(options);
      handler.resolve(await _retry(options, accessToken));
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  bool _shouldRefresh(DioException err) {
    final RequestOptions options = err.requestOptions;
    return err.response?.statusCode == HttpStatus.unauthorized &&
        options.extra[skipAuthKey] != true &&
        options.extra[_retriedKey] != true &&
        options.headers.containsKey(HttpHeaders.authorizationHeader);
  }

  Future<String?> _getValidAccessToken(RequestOptions options) {
    final String? accessToken = _tokenStorage.accessToken;
    final Object? usedAuthorization = options.headers[HttpHeaders.authorizationHeader];
    if (accessToken != null && usedAuthorization != _getBearer(accessToken)) {
      return Future<String?>.value(accessToken);
    }
    return _refreshRequest ??= _refreshAccessToken().whenComplete(() => _refreshRequest = null);
  }

  Future<String?> _refreshAccessToken() async {
    if (_tokenStorage.refreshToken == null) return null;
    try {
      final AuthTokens tokens = await serviceLocator.get<AuthService>().refreshTokens();
      return tokens.access;
    } on DioException catch (e) {
      if (e.response?.statusCode != HttpStatus.unauthorized) rethrow;
      serviceLocator.get<AuthCubit>().onSessionExpired();
      return null;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions options, String? accessToken) {
    options.extra[_retriedKey] = true;
    if (accessToken == null) {
      options.headers.remove(HttpHeaders.authorizationHeader);
      options.extra[skipAuthKey] = true;
    }
    return _dio.fetch<dynamic>(options);
  }

  bool _isApiRequest(RequestOptions options) {
    final Uri uri = options.uri;
    return uri.scheme == _apiUri.scheme && uri.host == _apiUri.host && uri.port == _apiUri.port;
  }

  String _getBearer(String accessToken) => "Bearer $accessToken";
}
