import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MySampleScreen extends StatefulWidget {
  const MySampleScreen({super.key});

  @override
  State<MySampleScreen> createState() => _MySampleScreenState();
}

class _MySampleScreenState extends State<MySampleScreen> {
  int _counter = 0;
  final SecureStorageService storage = SecureStorageService();

  void tokenFunction() async {
    final login = await storage.isLogin();
    final token = await storage.getAccessToken();
    print('$login: $token');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar.large(
        largeTitle: const Text('Community Study'),
        trailing: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            child: const Icon(CupertinoIcons.arrow_right_square),
            onTap: () async {
              await storage.clearAll();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
          ),
        ),
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
                  onPressed: () => {
                    setState(() => _counter++),
                    tokenFunction(),
                  },

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
