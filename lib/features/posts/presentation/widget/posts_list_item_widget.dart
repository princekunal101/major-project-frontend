import 'package:flutter/cupertino.dart';

class PostsListItemWidget extends StatelessWidget {
  final String postId;
  final String title;
  final String? subTitle;
  final String body;
  final int likesCount;
  final int commentCount;
  final String createdAt;
  final String postedBy;

  const PostsListItemWidget({
    super.key,
    required this.postId,
    required this.title,
     this.subTitle,
    required this.body,
    required this.likesCount,
    required this.commentCount,
    required this.createdAt,
    required this.postedBy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(postId),
          Text(title),
          Text('$subTitle'),
          Text(body),
          Text('$likesCount'),
          Text('$commentCount'),
          Text(createdAt),
          Text(postedBy),
        ],
      ),
    );
  }
}
