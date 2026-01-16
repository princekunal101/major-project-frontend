import 'package:flutter/cupertino.dart';

class SuccessPopup {
  static void show(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
