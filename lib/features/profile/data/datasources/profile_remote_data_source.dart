import 'dart:convert';
import 'dart:io';

import 'package:college_project/core/error/exceptions.dart';
import 'package:college_project/features/profile/data/models/is_username_available_model.dart';
import 'package:college_project/features/profile/data/models/profile_result_model.dart';
import 'package:dio/dio.dart';

class ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSource(this.dio);

  // final Duration timeLimit = const Duration(seconds: 10);

  Future<ProfileResultModel> fetchProfile() async {
    try {
      final response = await dio.get('/get-profile');
      // return ProfileResultModel.fromJson(response.data);
      if (response.statusCode == 200) {
        return ProfileResultModel.fromJson(response.data);
      } else {
        throw ServerException('Something went wrong! Try Again later');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ServerException('Session code is expired');
      } else {
        throw ServerException('Something went wrong! Try Again later');
      }
    } catch (e) {
      throw UnknownException('Something went wrong! Try Again later');
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await dio.put('/update-profile', data: jsonEncode(data));
      if (response.statusCode == 200) {
      } else if (response.statusCode == 400) {
        throw ServerException('Something went wrong! Try Again later');
      } else {
        throw ServerException('Something went wrong! Try Again later');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ServerException('Session code is expired');
      } else {
        throw ServerException('Something went wrong! Try Again later');
      }
    } catch (e) {
      throw ServerException(e.toString());
      // throw UnknownException('Something went wrong! Try Again later');
    }
  }

  Future<IsUsernameAvailableModel> checkIsAvailableUsername(
    String username,
  ) async {
    try {
      final response = await dio.get(
        '/check-username',
        data: jsonEncode({'username': username}),
      );
      if (response.statusCode == 200) {
        return IsUsernameAvailableModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        throw ServerException('Something went wrong! Try Again later');
      } else {
        throw ServerException('Something went wrong! Try Again later');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ServerException('Session code is expired');
      } else {
        throw ServerException('Something went wrong! Try Again later');
      }
    } catch (e) {
      throw UnknownException('Something went wrong! Try Again later');
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      final response = await dio.put(
        '/change-password',
        data: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
      } else if (response.statusCode == 400) {
        throw ServerException('Something went wrong! Try Again later');
      } else {
        throw ServerException('Something went wrong! Try Again later');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ServerException('Session code is expired');
      } else {
        throw ServerException('Something went wrong! Try Again later');
      }
    } catch (e) {
      throw UnknownException('Something went wrong! Try Again later');
    }
  }
}
