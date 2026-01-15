import 'dart:convert';
import 'dart:io';

import 'package:college_project/core/error/exceptions.dart';
import 'package:college_project/features/auth/data/models/auth_result_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  AuthRemoteDataSource(this.client, this.baseUrl);

  // for the sending the otp
  Future<void> sendOtp(String email) async {
    await client.post(
      Uri.parse('$baseUrl/signup-with-email'),
      body: {'email': email},
    );
  }

  // for the verifying the otp
  Future<void> verifyOtp(String email, String otp) async {
    await client.post(
      Uri.parse('$baseUrl/verify-signup-otp'),
      body: {'email': email, 'otp': otp},
    );
  }

  // for the login
  Future<AuthResultModel> login(String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return AuthResultModel(
          accessToken: jsonResponse['accessToken'],
          refreshToken: jsonResponse['refreshToken'],
          userId: jsonResponse['userId'],
        );
      } else if (response.statusCode == 400) {
        throw BadRequestException('Bad request: ${response.body}');
      } else if (response.statusCode == 401) {
        throw ServerException('Invalid Credentials');
        // } else if (response.statusCode == 503) {
        //   throw ServerException(
        //     'Status: ${response.statusCode}\n${jsonDecode(response.body)['message']}',
        //   );
      } else {
        throw ServerException(
          'Status: ${response.statusCode}\n${jsonDecode(response.body)['message'] ?? ''}',
        );
      }
    } on SocketException {
      throw NetworkException('No internet Connection');
    } on TimeoutException {
      throw TimeoutException('Request timeout');
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw UnknownException('Something went wrong');
    }
  }
}
