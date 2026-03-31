import 'package:college_project/core/widgets/avatar_image_widget.dart';
import 'package:college_project/core/widgets/community_avatar_image_widget.dart';
import 'package:flutter/cupertino.dart';

class CommunityListWidget extends StatelessWidget {
  final String communityId;
  final String displayName;
  final String? displayPicUrl;
  final String communityName;
  final int totalMember;
  final int totalPosts;

  const CommunityListWidget({
    super.key,
    required this.communityId,
    required this.displayName,
    this.displayPicUrl,
    required this.communityName,
    required this.totalMember,
    required this.totalPosts,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile.notched(
      leading: CommunityAvatarImageWidget(
        imgUrl: displayPicUrl ?? '',
        avatarRadius: 20,
      ),
      title: RichText(
        text: TextSpan(
          text: 'c/$communityName',
          style: TextStyle(
            color: CupertinoColors.label.resolveFrom(context),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: '\t($displayName)',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: CupertinoColors.secondaryLabel.resolveFrom(context),
              ),
            ),
          ],
        ),
      ),

      // Text('c/$communityName'),
      // subtitle: Row(
      //   spacing: 24,
      //   children: [Text('$totalMember members'), Text('$totalPosts posts')],
      // ),
      subtitle: Text('$totalPosts Total Posts'),
      onTap: () {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
          '/community-page',
          (route) => true,
          arguments: {
            'communityId': communityId,
            'communityName': communityName,
          },
        );
        // });
      },
    );
  }
}
