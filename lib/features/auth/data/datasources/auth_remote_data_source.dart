import 'dart:convert';

import 'package:college_project/features/auth/data/models/user_model.dart';
import 'package:college_project/features/auth/domain/entities/user.dart';
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

  Future<User> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body)['user']);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }
}
