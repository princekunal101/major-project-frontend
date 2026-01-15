import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/core/themes/my_cupertino_theme.dart';
import 'package:college_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:college_project/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:college_project/features/auth/domain/usecase/login_user.dart';
import 'package:college_project/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:college_project/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:college_project/features/auth/presentation/pages/login_page.dart';
import 'package:college_project/features/auth/presentation/pages/send_email_otp_page.dart';
import 'package:college_project/sample.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class AppRoutes extends StatelessWidget {
  final bool isLogin;
  final SecureStorageService storage;

  const AppRoutes({super.key, required this.isLogin, required this.storage});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      builder: (context, child) {
        final brightness = MediaQuery.of(context).platformBrightness;
        return CupertinoTheme(
          data: myCupertinoAppTheme(brightness),
          child: child!,
        );
      },
      title: 'Community Study',
      // theme: myCupertinoAppTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => isLogin
            ? MySampleScreen()
            : BlocProvider(
                create: (_) => LoginBloc(
                  LoginUser(
                    AuthRepositoryImpl(
                      AuthRemoteDataSource(
                        http.Client(),
                        dotenv.get('API_BASE_URL'),
                      ),
                      storage,
                    ),
                  ),
                ),
                child: LoginPage(),
              ),
        '/login': (context) => BlocProvider(
          create: (_) => LoginBloc(
            LoginUser(
              AuthRepositoryImpl(
                AuthRemoteDataSource(http.Client(), dotenv.get('API_BASE_URL')),
                storage,
              ),
            ),
          ),
          child: LoginPage(),
        ),
        '/send-email-otp': (context) => SendEmailOtpPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/dashboard': (context) => MySampleScreen(),
      },
    );
  }
}
