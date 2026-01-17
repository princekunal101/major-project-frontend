import 'package:flutter/cupertino.dart';

class ShowDialog {
  static void show(BuildContext context, Widget child) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 316,
        padding: EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(top: false, child: child),
      ),
    );
  }
}
