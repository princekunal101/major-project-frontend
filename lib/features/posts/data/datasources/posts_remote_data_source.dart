import 'dart:convert';
import 'dart:math';

import 'package:college_project/core/error/exceptions.dart';
import 'package:college_project/features/posts/data/models/post_list_response_model.dart';
import 'package:dio/dio.dart';

class PostsRemoteDataSource {
  final Dio dio;

  PostsRemoteDataSource(this.dio);

  Future<PostListResponseModel> fetchPosts(
    String? communityId,
    String? userId,
    String? searchString,
    String? nextCursor,
    int? limit,
  ) async {
    try {
      final response = await dio.get(
        '/get-posts',
        queryParameters: {
          if (communityId != null) "communityId": communityId,
          if (userId != null) "userId": userId,
          if (searchString != null) "title": searchString,
          if (nextCursor != null) "cursor": nextCursor,
          if (limit != null) "limit": 10,
        },
      );

      if (response.statusCode == 200) {
        return PostListResponseModel.fromJson(response.data);
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

  // Future<PostListResponseModel> fetchCommunityPosts(
  //   String communityId,
  //   String? nextCursor,
  // ) async {
  //   try {
  //     final response = await dio.get(
  //       '/get-posts',
  //       queryParameters: {
  //         "communityId": communityId,
  //         if (nextCursor != null) "cursor": nextCursor,
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       return PostListResponseModel.fromJson(response.data);
  //     } else {
  //       // throw ServerException('${response.data}');
  //       throw ServerException('Something went wrong! Try Again later');
  //     }
  //   } on DioException catch (e) {
  //     if (e.response?.statusCode == 401) {
  //       throw ServerException('Session code is expired');
  //     } else {
  //       // throw ServerException('${e.response?.data}');
  //       throw ServerException('Something went wrong! Try Again later');
  //     }
  //   } catch (e) {
  //     // throw ServerException(e.toString());
  //     throw UnknownException('Something went wrong! Try Again later');
  //   }
  // }

  // Future<PostListResponseModel> fetchUserPosts(
  //   String userId,
  //
  //   String? nextCursor,
  // ) async {
  //   try {
  //     final response = await dio.get(
  //       '/get-posts',
  //       queryParameters: {
  //         "userId": userId,
  //         if (nextCursor != null) "cursor": nextCursor,
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       return PostListResponseModel.fromJson(response.data);
  //     } else {
  //       // throw ServerException('${response.data}');
  //       throw ServerException('Something went wrong! Try Again later');
  //     }
  //   } on DioException catch (e) {
  //     if (e.response?.statusCode == 401) {
  //       throw ServerException('Session code is expired');
  //     } else {
  //       // throw ServerException('${e.response?.data}');
  //       throw ServerException('Something went wrong! Try Again later');
  //     }
  //   } catch (e) {
  //     // throw ServerException(e.toString());
  //     throw UnknownException('Something went wrong! Try Again later');
  //   }
  // }

  // for creating a new post
  Future<void> createNewPost(Map<String, dynamic> data) async {
    try {
      final response = await dio.post('/create-post', data: jsonEncode(data));
      if (response.statusCode == 201) {
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
}
