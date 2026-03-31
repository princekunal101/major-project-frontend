import 'package:college_project/core/error/exceptions.dart';
import 'package:college_project/features/posts/data/models/post_list_response_model.dart';
import 'package:dio/dio.dart';

class PostsRemoteDataSource {
  final Dio dio;

  PostsRemoteDataSource(this.dio);

  Future<PostListResponseModel> postsResponse(
    String communityId,
    String? searchString,
    String? nextCursor,
  ) async {
    try {
      final response = await dio.get(
        '/get-posts',
        queryParameters: {
          "communityId": communityId,
          if (nextCursor != null) "cursor": nextCursor,
          if (searchString != null) "title": searchString,
        },
      );
      print(response);
      if (response.statusCode == 200) {
        return PostListResponseModel.fromJson(response.data);
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
