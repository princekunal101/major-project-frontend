import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;
  final SecureStorageService storage;

  TokenInterceptor(this.dio, this.storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Content-Type'] = 'application/json';
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestPath = err.requestOptions.path;

    if (err.response?.statusCode == 401 && requestPath != '/refresh-token') {
      final refreshToken = await storage.getRefreshToken();
      if (refreshToken != null) {
        try {
          final response = await dio.post(
            '/refresh-token',
            data: {'refreshToken': refreshToken},
            options: Options(headers: {'Content-Type': 'application/json'}),
          );

          final newAccessToken = response.data['accessToken'];
          final newRefreshToken = response.data['refreshToken'];

          // if (newAccessToken != null && newRefreshToken != null) {
          await storage.updateAccessToken(newAccessToken, newRefreshToken);
          // }

          final retry = err.requestOptions;
          retry.headers['Authorization'] = 'Bearer $newAccessToken';

          final cloned = await dio.fetch(retry);
          return handler.resolve(cloned);
        } catch (error) {
          await storage.clearAll();
        }
      }
    }
    return handler.next(err);
  }
}
