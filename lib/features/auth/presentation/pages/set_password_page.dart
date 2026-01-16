import 'package:flutter/cupertino.dart';

class SetPasswordPage extends StatefulWidget {
  final String email;

  const SetPasswordPage({super.key, required this.email});

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final setPasswordController = TextEditingController();

  void _onSubmit() {}

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Create Your Password'),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16.0),
          child: Column(
            spacing: 12,
            children: [
              Text(
                'Create a password with a least 8 letters. It should be at least one capital, one small, one number, one special character.',
                style: TextStyle(fontSize: 14),
              ),
              CupertinoTextField(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                placeholder: 'Password',
                controller: setPasswordController,
              ),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  sizeStyle: CupertinoButtonSize.medium,
                  child: Text('Next'),
                  onPressed: () {},
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.tinted(
                  sizeStyle: CupertinoButtonSize.medium,
                  child: Text('I have already an account'),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
