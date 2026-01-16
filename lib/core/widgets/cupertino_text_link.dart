import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class CupertinoTextLink extends StatelessWidget {
  final String url;
  final String text;

  const CupertinoTextLink({super.key, required this.url, required this.text});

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Cloud not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchUrl(),
      child: Text(text, style: TextStyle(color: CupertinoColors.link)),
    );
  }
}
