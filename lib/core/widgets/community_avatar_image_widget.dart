import 'package:flutter/cupertino.dart';

class CommunityAvatarImageWidget extends StatelessWidget {
  final String? imgUrl;
  final double avatarRadius;

  const CommunityAvatarImageWidget({
    super.key,
    this.imgUrl,
    this.avatarRadius = 30,
  });

  @override
  Widget build(BuildContext context) {
    if (imgUrl == null || imgUrl!.isEmpty) {
      return Center(
        child: ClipOval(
          child: SizedBox.fromSize(
            size: Size.fromRadius(avatarRadius),
            child: Image.asset(
              'assets/logo/cs_study_logo.png',
              // fit: BoxFit.scaleDown,
            ),
          ),
        ),
      );
    }
    return Center(
      child: ClipOval(
        child: SizedBox.fromSize(
          size: Size.fromRadius(avatarRadius),
          child: Image.network(
            imgUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, child, stackTrace) {
              return Image.asset(
                'assets/logo/cs_study_logo.png',
                fit: BoxFit.cover,
              );
            },

            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: CupertinoColors.tertiarySystemGroupedBackground
                    .resolveFrom(context),
                child: Center(child: CupertinoActivityIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }
}
