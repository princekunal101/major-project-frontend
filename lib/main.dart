import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: CupertinoColors.transparent,
      systemNavigationBarColor: CupertinoColors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: CupertinoColors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  WidgetsFlutterBinding.ensureInitialized();
  final SecureStorageService storage = SecureStorageService();
  final isLogin = await storage.isLogin();
  await dotenv.load(fileName: ".env");
  runApp(AppRoutes(isLogin: isLogin, storage: storage));
}
