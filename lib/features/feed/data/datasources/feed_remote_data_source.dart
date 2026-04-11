import 'package:college_project/core/error/exceptions.dart';
import 'package:college_project/features/feed/data/models/community_list_response_model.dart';
import 'package:college_project/features/feed/data/models/feed_list_response_model.dart';
import 'package:dio/dio.dart';

class FeedRemoteDataSource {
  final Dio dio;

  FeedRemoteDataSource(this.dio);

  Future<CommunityListResponseModel> searchCommunity(
    String? communityName,
    String? displayName,
  ) async {
    try {
      final response = await dio.get(
        '/search-communities',
        queryParameters: {
          if (communityName != null) "communityName": communityName,
          if (displayName != null) "displayName": displayName,
        },
      );

      if (response.statusCode == 200) {
        return CommunityListResponseModel.fromJson(response.data);
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

  // fetching the feed as pagination form
  Future<FeedListResponseModel> getFeeds(String? cursor, int? limit) async {
    try {
      final response = await dio.get(
        '/get-feeds',
        queryParameters: {
          if (cursor != null) "cursor": cursor,
          if (limit != null) "limit": limit,
        },
      );

      if (response.statusCode == 200) {
        return FeedListResponseModel.fromJson(response.data);
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

  // fetching the feed as pagination form
  Future<FeedListResponseModel> getAllPosts(String? cursor, int? limit) async {
    try {
      final response = await dio.get(
        '/get-all-posts',
        queryParameters: {
          if (cursor != null) "cursor": cursor,
          if (limit != null) "limit": limit,
        },
      );

      if (response.statusCode == 200) {
        return FeedListResponseModel.fromJson(response.data);
      } else {
        throw ServerException('${response.data}');
        throw ServerException('Something went wrong! Try Again later');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ServerException('Session code is expired');
      } else {
        throw ServerException('${e.response?.data}');
        throw ServerException('Something went wrong! Try Again later');
      }
    } catch (e) {
      throw ServerException(e.toString());
      throw UnknownException('Something went wrong! Try Again later');
    }
  }
}
