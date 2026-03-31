import 'package:flutter/cupertino.dart';

class CommentsContainerWidget extends StatefulWidget {
  const CommentsContainerWidget({super.key});

  @override
  State<CommentsContainerWidget> createState() =>
      _CommentsContainerWidgetState();
}

class _CommentsContainerWidgetState extends State<CommentsContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Icon(CupertinoIcons.chat_bubble_text, size: 100),
            Text(
              'You don\'t have any comments',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'When you comment on a post in the community, it will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: CupertinoColors.secondaryLabel.resolveFrom(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
