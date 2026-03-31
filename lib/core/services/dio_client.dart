import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/core/services/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  final Dio dio;

  DioClient(SecureStorageService storage)
    : dio = Dio(BaseOptions(baseUrl: dotenv.get('API_BASE_URL'))) {
    dio.interceptors.add(TokenInterceptor(dio, storage));
  }
}
