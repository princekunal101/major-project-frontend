import 'package:college_project/core/utils/enums/community_shared_value.dart';
import 'package:college_project/core/utils/enums/community_topic.dart';
import 'package:college_project/core/utils/enums/community_type.dart';
import 'package:flutter/cupertino.dart';

class CommunityTypePage extends StatefulWidget {
  final CommunityTopic topic;
  final CommunitySharedValue sharedValue;

  const CommunityTypePage({
    super.key,
    required this.topic,
    required this.sharedValue,
  });

  @override
  State<CommunityTypePage> createState() => _CommunityTypePageState();
}

class _CommunityTypePageState extends State<CommunityTypePage> {
  late CommunityType communityType = CommunityType.public;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'About',
        middle: Text('Select Community Type'),
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(
                context,
                // rootNavigator: true,
              ).pushNamed(
                '/community-details',

                arguments: {
                  'topic': widget.topic,
                  'sharedValue': widget.sharedValue,
                  'communityType': communityType
                },
              );
            });
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: RadioGroup(
                groupValue: communityType,
                onChanged: (CommunityType? value) {
                  setState(() {
                    communityType = value!;
                  });
                },
                child: CupertinoListSection(
                  header: Text(
                    'Decide who can view ans contribute in your community. Only public communities show up in search.',
                  ),
                  children: [
                    CupertinoListTile.notched(
                      title: Text('Public'),
                      leading: Icon(CupertinoIcons.globe),
                      subtitle: Text('Anyone can search, view, and contribute'),
                      trailing: CupertinoRadio(value: CommunityType.public),
                      onTap: () {
                        setState(() {
                          communityType = CommunityType.public;
                        });
                      },
                    ),
                    CupertinoListTile.notched(
                      title: Text('Restricted'),
                      leading: Icon(CupertinoIcons.eye),
                      subtitle: Text(
                        'Anyone can view, but restrict who can contribute',
                      ),
                      trailing: CupertinoRadio(value: CommunityType.restricted),
                      onTap: () {
                        setState(() {
                          communityType = CommunityType.restricted;
                        });
                      },
                    ),
                    CupertinoListTile.notched(
                      title: Text('Private'),
                      leading: Icon(CupertinoIcons.lock),
                      subtitle: Text(
                        'Only approved members can view and contribute',
                      ),
                      trailing: CupertinoRadio(value: CommunityType.private),
                      onTap: () {
                        setState(() {
                          communityType = CommunityType.private;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
