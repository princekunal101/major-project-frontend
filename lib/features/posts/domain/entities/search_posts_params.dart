class SearchPostsParams {
  final String? communityId;
  final String? userId;
  final String? title;
  final String? cursor;
  final int? limit;

  SearchPostsParams({
    this.communityId,
    this.userId,
    this.title,
    this.cursor,
    this.limit,
  });
}
