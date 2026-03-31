import 'package:flutter/cupertino.dart';

class CommunityRulesWidgetPopup extends StatefulWidget {
  const CommunityRulesWidgetPopup({super.key});

  @override
  State<CommunityRulesWidgetPopup> createState() =>
      _CommunityRulesWidgetPopupState();
}

class _CommunityRulesWidgetPopupState extends State<CommunityRulesWidgetPopup> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Create Posts',
        middle: Text('Rules'),
        trailing: CupertinoButton(
          padding: EdgeInsetsGeometry.all(0),
          child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: SafeArea(child: SizedBox(width: double.infinity,
        child: Column(

            children: [Text('No Rules Added')]),
      )),
    );
  }
}
