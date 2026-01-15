import 'package:flutter/cupertino.dart';

class SendEmailOtpPage extends StatefulWidget {
  const SendEmailOtpPage({super.key});

  @override
  State<SendEmailOtpPage> createState() => _SendEmailOtpPageState();
}

class _SendEmailOtpPageState extends State<SendEmailOtpPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child: SafeArea(child: const Center(child: Text('Email OTP Screen'))),
    );
  }
}
