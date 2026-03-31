import 'dart:convert';

import 'package:college_project/core/error/exceptions.dart';
import 'package:college_project/features/community/data/models/community_id_and_name_model.dart';
import 'package:college_project/features/community/data/models/community_result_model.dart';
import 'package:college_project/features/community/data/models/is_community_name_available_model.dart';
import 'package:dio/dio.dart';

class CommunityRemoteDataSource {
  final Dio dio;

  CommunityRemoteDataSource(this.dio);

  Future<CommunityIdAndNameModel> createCommunity(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await dio.post(
        '/create-community',
        data: jsonEncode(data),
      );

      // final ruleResponse = await dio.post('/create-rules/${response.data['communityId']}');
      // final updatedCommunity = await dio.put(
      //   '/update-community/${response.data['communityId']}',
      //   data: jsonEncode({"rule": ruleResponse.data['_id']}),
      // );
      // if (updatedCommunity.statusCode == 200) {
      if (response.statusCode == 201) {
        return CommunityIdAndNameModel.fomJson(response.data);
      } else {
        // throw ServerException('${response.data}');
        throw ServerException('Something went wrong! Try Again later');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ServerException('Session code is expired');
      } else {
        // throw ServerException('${e.response?.data}');
        throw ServerException('Something went wrong! Try Again later');
      }
    } catch (e) {
      // throw ServerException(e.toString());
      throw UnknownException('Something went wrong! Try Again later');
    }
  }

  Future<IsCommunityNameAvailableModel> checkCommunityNameAvailability(
    String communityName,
  ) async {
    try {
      final response = await dio.get(
        '/check-community',
        data: jsonEncode({'communityName': communityName}),
      );
      if (response.statusCode == 200) {
        return IsCommunityNameAvailableModel.fromJson(response.data);
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

  Future<CommunityResultModel> getCommunityById(String communityId) async {
    try {
      final response = await dio.get('/community/$communityId');

      if (response.statusCode == 200) {
        return CommunityResultModel.fromJson(response.data);
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
      // throw ServerException(e.toString());
      throw UnknownException('Something went wrong! Try Again later');
    }
  }

  Future<void> createRules(String communityId) async {
    try {
      final response = await dio.post('/create-rules/$communityId');
      if (response.statusCode == 200) {
        // return CommunityResultModel.fromJson(response.data);
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
      // throw ServerException(e.toString());
      throw UnknownException('Something went wrong! Try Again later');
    }
  }

  Future<void> fetchRules(String rulesId) async {
    try {
      final response = await dio.get('/fetch-rules/$rulesId');

      if (response.statusCode == 200) {
        // return CommunityResultModel.fromJson(response.data);
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
      // throw ServerException(e.toString());
      throw UnknownException('Something went wrong! Try Again later');
    }
  }
}
