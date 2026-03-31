import 'package:college_project/core/utils/enums/community_shared_value.dart';
import 'package:college_project/core/utils/enums/community_topic.dart';
import 'package:college_project/core/utils/enums/community_type.dart';

import 'package:flutter/cupertino.dart';

class AboutCommunityPage extends StatefulWidget {
  const AboutCommunityPage({super.key});

  @override
  State<AboutCommunityPage> createState() => _AboutCommunityPageState();
}

class _AboutCommunityPageState extends State<AboutCommunityPage> {
  CommunityTopic? communityTopic;
  CommunitySharedValue? sharedValue;

  // bool isButtonEnabled = false;
  //
  // void buttonEnabled() {}

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Feeds',
        middle: Text('About your community?'),
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          onPressed: (communityTopic == null || sharedValue == null)
              ? null
              : () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(
                      context,
                      // rootNavigator: true,
                    ).pushNamed(
                      '/community-type',

                      arguments: {
                        'topic': communityTopic,
                        'sharedValue': sharedValue,
                      },
                    );
                  });
                },
          child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                spacing: 4,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          // width: double.infinity,
                          height: 0.5,
                          color: CupertinoColors.separator,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: CupertinoColors.separator,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Text('Community Topic'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // width: double.infinity,
                          height: 0.5,
                          color: CupertinoColors.separator,
                        ),
                      ),
                    ],
                  ),

                  for (var value in CommunityTopic.values)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          communityTopic = value;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              communityTopic != null && communityTopic == value
                              ? CupertinoColors.activeBlue
                              : null,
                          border: Border.all(
                            width: 1,
                            color: CupertinoColors.separator,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 16,
                          ),
                          child: Text(
                            value.title,
                            style: TextStyle(
                              color:
                                  communityTopic != null &&
                                      communityTopic == value
                                  ? CupertinoColors.white
                                  : CupertinoColors.label.resolveFrom(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                spacing: 4,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          // width: double.infinity,
                          height: 0.5,
                          color: CupertinoColors.separator,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: CupertinoColors.separator,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Text('Shared Value'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // width: double.infinity,
                          height: 0.5,
                          color: CupertinoColors.separator,
                        ),
                      ),
                    ],
                  ),
                  for (var value in CommunitySharedValue.values)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          sharedValue = value;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: sharedValue != null && sharedValue == value
                              ? CupertinoColors.activeBlue
                              : null,
                          border: Border.all(
                            width: 1,
                            color: CupertinoColors.separator,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 16,
                          ),
                          child: Text(
                            value.title,
                            style: TextStyle(
                              color: sharedValue != null && sharedValue == value
                                  ? CupertinoColors.white
                                  : CupertinoColors.label.resolveFrom(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
