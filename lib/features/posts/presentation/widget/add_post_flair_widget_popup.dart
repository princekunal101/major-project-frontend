import 'package:flutter/cupertino.dart';

class AddPostFlairWidgetPopup extends StatefulWidget {
  const AddPostFlairWidgetPopup({super.key});

  @override
  State<AddPostFlairWidgetPopup> createState() =>
      _AddPostFlairWidgetPopupState();
}

class _AddPostFlairWidgetPopupState extends State<AddPostFlairWidgetPopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
      ),

      height: 500,
      child: Center(child: Text('Flair and Keywords')),
    );
  }
}
