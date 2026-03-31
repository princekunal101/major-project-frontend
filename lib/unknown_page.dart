import 'package:flutter/cupertino.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(child: Text('Ops, this is unknown page')),
    );
  }
}
