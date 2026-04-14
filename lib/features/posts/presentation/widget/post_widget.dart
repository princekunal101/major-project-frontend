import 'package:college_project/core/services/dio_client.dart';
import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:college_project/features/posts/data/repositories/post_repositories_impl.dart';
import 'package:college_project/features/posts/domain/usecase/post_reaction.dart';
import 'package:college_project/features/posts/presentation/bloc/fetch_post_reaction_bloc/fetch_post_reaction_bloc.dart';
import 'package:college_project/features/posts/presentation/bloc/fetch_post_reaction_bloc/fetch_post_reaction_event.dart';
import 'package:college_project/features/posts/presentation/bloc/posts_reaction_bloc/post_reaction_bloc.dart';
import 'package:college_project/features/posts/presentation/bloc/posts_reaction_bloc/post_reaction_event.dart';
import 'package:college_project/features/posts/presentation/bloc/posts_reaction_bloc/post_reaction_state.dart';
import 'package:college_project/features/posts/presentation/widget/comments_list_popup_widget.dart';
import 'package:college_project/features/posts/presentation/widget/likes_list_popup_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  final String id;
  final String username;
  final String communityName;
  final String? userImg;
  final String? communityImg;
  final String title;
  final String? subTitle;
  final String body;

  final String? summaryTitle;
  final String? summaryBody;
  final int likeCount;
  final int commentCount;
  final String createdAt;
  final bool isLikedByMe;
  final bool? isFollowing;

  final VoidCallback? onLikeButtonPress;

  final storage = SecureStorageService();
  late final dioClient = DioClient(storage);

  PostWidget({
    super.key,
    required this.id,
    required this.username,
    required this.communityName,
    required this.userImg,
    this.communityImg,
    required this.title,
    this.subTitle,
    required this.body,

    this.summaryTitle,
    this.summaryBody,
    this.likeCount = 0,
    this.commentCount = 0,
    required this.createdAt,
    this.isFollowing,
    required this.isLikedByMe,

    this.onLikeButtonPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // banner rows
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Row(
            spacing: 4,
            children: [
              Stack(
                alignment: AlignmentGeometry.bottomEnd,
                children: [
                  // Community Img,
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      bottom: 4.0,
                      top: 4.0,
                    ),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey4,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),

                  // User Img,
                  Container(
                    height: 27,
                    width: 27,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey2,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(
                        color: CupertinoColors.systemBackground,
                        width: 1.5,
                      ),
                    ),
                  ),
                ],
              ),

              // Names
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Community Name,
                  Text(
                    'c/$communityName',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  // User Name
                  Text(
                    'u/$username',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: CupertinoColors.secondaryLabel.resolveFrom(
                        context,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              isFollowing != null
                  ? CupertinoButton.filled(
                      sizeStyle: CupertinoButtonSize.small,
                      color: isFollowing!
                          ? CupertinoColors.separator.resolveFrom(context)
                          : CupertinoColors.systemBlue,
                      child: Text(isFollowing! ? 'Joined' : 'Join'),
                      onPressed: () {},
                    )
                  : Container(),
              CupertinoButton(
                sizeStyle: CupertinoButtonSize.medium,
                padding: EdgeInsetsGeometry.all(0),
                child: Icon(CupertinoIcons.ellipsis_vertical),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: CupertinoColors.separator.resolveFrom(context),
        ),

        Stack(
          alignment: AlignmentGeometry.topRight,
          children: [
            // post dateTime
            Container(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 2.0,
                horizontal: 6.0,
              ),
              decoration: BoxDecoration(
                color: CupertinoColors.separator.resolveFrom(context),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
              ),
              child: Text(
                timeago.format(DateTime.parse(createdAt)),
                style: TextStyle(fontSize: 14, color: CupertinoColors.white),
              ),
            ),
            // post content
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  // SubTitle if have
                  subTitle != null
                      ? Text(
                          subTitle!,
                          style: TextStyle(
                            color: CupertinoColors.secondaryLabel.resolveFrom(
                              context,
                            ),
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                          ),
                        )
                      : Container(),
                  // Text Body
                  Text(body, style: TextStyle(fontSize: 15)),

                  ?(summaryTitle != null && summaryBody != null)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Container(
                                // padding: EdgeInsets.symmetric(vertical: 18.0),
                                height: 0.5,
                                width: double.infinity,
                                color: CupertinoColors.separator.resolveFrom(
                                  context,
                                ),
                              ),
                            ),
                            Text(
                              '$summaryTitle',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: CupertinoColors.secondaryLabel
                                    .resolveFrom(context),
                              ),
                            ),
                            Text(
                              '$summaryBody',
                              style: TextStyle(
                                fontSize: 14,
                                color: CupertinoColors.secondaryLabel
                                    .resolveFrom(context),
                              ),
                            ),
                          ],
                        )
                      : null,
                ],
              ),
            ),
          ],
        ),

        Container(
          width: double.infinity,
          height: 1,
          color: CupertinoColors.separator.resolveFrom(context),
        ),

        //interactions
        SizedBox(
          height: 40,
          child: Row(
            children: [
              // likes
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    onLikeButtonPress?.call();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    width: double.infinity,
                    // color: CupertinoColors.systemGreen,
                    child: Text(
                      isLikedByMe ? 'Liked' : 'Unliked',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isLikedByMe
                            ? CupertinoColors.systemPink
                            : CupertinoColors.secondaryLabel.resolveFrom(
                                context,
                              ),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              // Spacer(),
              Container(
                height: double.infinity,
                width: 0.5,
                color: CupertinoColors.separator.resolveFrom(context),
              ),

              Expanded(
                flex: 1,
                child: GestureDetector(
                  // for popup like lists
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => BlocProvider<FetchPostReactionBloc>(
                        create: (_) =>
                            FetchPostReactionBloc(
                                PostRepositoriesImpl(
                                  PostsRemoteDataSource(dioClient.dio),
                                ),
                              )
                              ..add(FetchLikedUsers(id))
                              ..add(FetchLikeCount(id)),
                        child: LikesListPopupWidget(
                          postId: id,
                          likeCounts: likeCount,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    // color: CupertinoColors.systemRed,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    width: double.infinity,

                    child: Text(
                      'All likes',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.secondaryLabel.resolveFrom(
                          context,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 16,
          color: CupertinoColors.secondarySystemFill.resolveFrom(context),
        ),
      ],
    );
  }
}
