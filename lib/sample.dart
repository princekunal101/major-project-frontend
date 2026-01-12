import 'package:flutter/cupertino.dart';

class MySampleScreen extends StatefulWidget {
  const MySampleScreen({super.key});

  @override
  State<MySampleScreen> createState() => _MySampleScreenState();
}

class _MySampleScreenState extends State<MySampleScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar.large(
        largeTitle: Text('Community Study'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const Spacer(),
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: CupertinoTheme.of(
                  context,
                ).textTheme.navLargeTitleTextStyle,
              ),
              const Text('(Cupertino Library)'),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CupertinoButton.filled(
                  onPressed: () => setState(() => _counter++),

                  sizeStyle: CupertinoButtonSize.large,
                  child: const Text('Increment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
