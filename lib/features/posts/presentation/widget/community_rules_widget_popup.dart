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
      resizeToAvoidBottomInset: false,
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
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 32,
              children: [
                Text(
                  'Rules are different from each community. Reviewing the rules can help you be more successful when posting or commenting in this community.',
                  style: TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 32,
                  children: [
                    Text('1. Remember the human.'),
                    Text('2. Abide by community rules.'),
                    Text('3. Respect the privacy of others.'),
                    Text('4. Don\'t impersonate people or entities.'),
                    Text('5. Properly label Not Safe for Work (NSFW) content.'),
                    Text('6. Keep it legal.'),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    sizeStyle: CupertinoButtonSize.medium,
                    child: Text('Understood!'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
