import 'dart:convert';
import 'dart:io';

import 'package:college_project/core/error/exceptions.dart';
import 'package:college_project/features/auth/data/models/auth_result_model.dart';
import 'package:college_project/features/auth/data/models/resend_otp_cool_down_model.dart';
import 'package:college_project/features/auth/data/models/user_id_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  AuthRemoteDataSource(this.client, this.baseUrl);

  // for the sending the otp
  Future<void> signupWithEmail(String email) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/signup-with-email'),
        body: {'email': email},
      );

      if (response.statusCode == 201) {
      } else if (response.statusCode == 400) {
        throw BadRequestException('Enter a valid email address.');
      } else if (response.statusCode == 409) {
        throw ServerException('Email is already registered! Try Another');
      } else {
        throw ServerException(
          'Status: ${response.statusCode}\n${jsonDecode(response.body)['message'] ?? ''}',
        );
      }
    } on SocketException {
      throw NetworkException('Something went wrong! Try Again later');
    } on TimeoutException {
      throw TimeoutException('Request timeout');
    } on BadRequestException catch (e) {
      throw BadRequestException(e.message);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw UnknownException('Something went wrong! Try Again later');
    }
  }

  // for the verifying the otp
  Future<void> verifyOtp(String email, String otp) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/verify-signup-otp'),
        body: {'email': email, 'otp': otp},
      );
      if (response.statusCode == 201) {
      } else if (response.statusCode == 400) {
        throw BadRequestException('Enter a valid input fields.');
      } else if (response.statusCode == 404) {
        throw ServerException('Something went wrong! Try Again later');
      } else if (response.statusCode == 401) {
        throw ServerException('Enter the valid otp');
      } else {
        throw ServerException(
          'Status: ${response.statusCode}\n${jsonDecode(response.body)['message'] ?? ''}',
        );
      }
    } on SocketException {
      throw NetworkException('Something went wrong! Try Again later');
    } on TimeoutException {
      throw TimeoutException('Request timeout');
    } on BadRequestException catch (e) {
      throw BadRequestException(e.message);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw UnknownException('Something went wrong! Try Again later');
    }
  }

  // for resend the otp
  Future<ResendOtpCoolDownModel> resendOtp(String email) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/resend-otp'),
        body: {'email': email},
      );

      if (response.statusCode == 201) {
        return ResendOtpCoolDownModel(
          coolDownTimer: jsonDecode(response.body)['coolDown'],
        );
      } else if (response.statusCode == 400) {
        throw BadRequestException('Enter a valid email address.');
      } else if (response.statusCode == 409) {
        throw ServerException('Email is already registered! Try Another');
      } else if (response.statusCode == 429) {
        throw ServerException(
          'You have tried multiple times at once! wait or try later',
        );
      } else {
        throw ServerException(
          'Status: ${response.statusCode}\n${jsonDecode(response.body)['message'] ?? ''}',
        );
      }
    } on SocketException {
      throw NetworkException('Something went wrong! Try Again later');
    } on TimeoutException {
      throw TimeoutException('Request timeout');
    } on BadRequestException catch (e) {
      throw BadRequestException(e.message);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw UnknownException('Something went wrong! Try Again later');
    }
  }

  // for creating password
  Future<UserIdModel> setPassword(String email, String createPassword) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl/set-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': createPassword}),
      );
      if (response.statusCode == 200) {
        return UserIdModel(userId: jsonDecode(response.body)['userId']);
      } else if (response.statusCode == 400) {
        throw BadRequestException('Enter a valid input fields.');
      } else if (response.statusCode == 401) {
        throw ServerException('Something went wrong! Try Again later');
      } else {
        throw ServerException(
          'Status: ${response.statusCode}\n${jsonDecode(response.body)['message'] ?? ''}',
        );
      }
    } on SocketException {
      throw NetworkException('Something went wrong! Try Again later');
    } on TimeoutException {
      throw TimeoutException('Request timeout');
    } on BadRequestException catch (e) {
      throw BadRequestException(e.message);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (error) {
      throw UnknownException('Something went wrong! Try Again later');
    }
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
        throw BadRequestException('Enter a valid email address.');
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
      throw NetworkException('Something went wrong! Try Again later');
    } on TimeoutException {
      throw TimeoutException('Request timeout');
    } on BadRequestException catch (e) {
      throw BadRequestException(e.message);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw UnknownException('Something went wrong! Try Again later');
    }
  }
}
