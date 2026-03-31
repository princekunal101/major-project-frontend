import 'package:flutter/cupertino.dart';

class PostsContainerWidget extends StatefulWidget {
  const PostsContainerWidget({super.key});

  @override
  State<PostsContainerWidget> createState() => _PostsContainerWidgetState();
}

class _PostsContainerWidgetState extends State<PostsContainerWidget> {
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
            Icon(CupertinoIcons.pencil_outline, size: 100,),
            Text(
              'You don\'t have any posts',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'When you create a post in a community, it will appear here.',
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
