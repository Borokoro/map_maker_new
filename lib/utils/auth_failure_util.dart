import 'dart:io';

import 'package:dio/dio.dart';
import 'package:map_maker_new/types/enum/auth_failure_type.dart';

abstract class AuthFailureUtil {
  static AuthFailureType getFailureType(Object exception) {
    if (exception is! DioException) return AuthFailureType.unknown;
    switch (exception.response?.statusCode) {
      case HttpStatus.badRequest:
        return AuthFailureType.invalidData;
      case HttpStatus.unauthorized:
        return AuthFailureType.invalidCredentials;
      case HttpStatus.tooManyRequests:
        return AuthFailureType.tooManyRequests;
      case null:
        return AuthFailureType.network;
      default:
        return AuthFailureType.unknown;
    }
  }

  static Map<String, String> getFieldErrors(Object exception) {
    if (exception is! DioException) return const {};
    final Object? body = exception.response?.data;
    if (body is! Map<String, dynamic>) return const {};
    final Object? data = body["data"];
    if (data is! Map<String, dynamic>) return const {};
    final Map<String, String> fieldErrors = {};
    for (final MapEntry<String, dynamic> entry in data.entries) {
      final Object? messages = entry.value;
      if (messages is List && messages.isNotEmpty) {
        fieldErrors[entry.key] = messages.first.toString();
      } else if (messages is String) {
        fieldErrors[entry.key] = messages;
      }
    }
    return fieldErrors;
  }
}
