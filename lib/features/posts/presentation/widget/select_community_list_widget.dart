import 'package:flutter/cupertino.dart';

class SelectCommunityListWidget extends StatefulWidget {
  const SelectCommunityListWidget({super.key});

  @override
  State<SelectCommunityListWidget> createState() =>
      _SelectCommunityListWidgetState();
}

class _SelectCommunityListWidgetState extends State<SelectCommunityListWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Edit Post',
        middle: Text('Select a Community'),
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {},
        ),
      ),
      child: SafeArea(child: Center(child: Text('Community List!'))),
    );
  }
}
