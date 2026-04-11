import 'package:college_project/features/posts/presentation/widget/comments_list_popup_widget.dart';
import 'package:college_project/features/posts/presentation/widget/likes_list_popup_widget.dart';
import 'package:flutter/cupertino.dart';

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

  final bool? isFollowing;

  const PostWidget({
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

    this.isFollowing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // banner rows
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 4.0,
          ),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
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
                          ? CupertinoColors.separator.resolveFrom(
                              context,
                            )
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
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Text(
                '5 min ago',
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
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

                  ?summaryTitle != null && summaryBody != null
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
          child: Row(
            children: [
              // likes
              Row(
                children: [
                  //like icon
                  CupertinoButton(
                    sizeStyle: CupertinoButtonSize.medium,
                    padding: EdgeInsetsGeometry.all(0),
                    child: Icon(CupertinoIcons.heart_circle_fill),
                    onPressed: () {},
                  ),
                  // like counts
                  GestureDetector(
                    // for popup like lists
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => LikesListPopupWidget(
                          postId: '',
                          likeCounts: likeCount,
                        ),
                      );
                    },
                    child: Text(
                      '$likeCount likes',
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.secondaryLabel.resolveFrom(
                          context,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Spacer(),
              // comments
              Row(
                children: [
                  //like icon
                  CupertinoButton(
                    sizeStyle: CupertinoButtonSize.medium,
                    padding: EdgeInsetsGeometry.all(0),
                    child: Icon(CupertinoIcons.chat_bubble_text_fill),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => CommentsListPopupWidget(
                          postId: '',
                          commentCounts: commentCount,
                        ),
                      );
                    },
                  ),
                  // like counts
                  GestureDetector(
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => CommentsListPopupWidget(
                          postId: '',
                          commentCounts: commentCount,
                        ),
                      );
                    },
                    child: Text(
                      '$commentCount comments',
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.secondaryLabel.resolveFrom(
                          context,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // comments
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
