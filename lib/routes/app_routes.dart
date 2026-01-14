import 'package:college_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:college_project/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:college_project/features/auth/domain/usecase/login_user.dart';
import 'package:college_project/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:college_project/features/auth/presentation/pages/login_page.dart';
import 'package:college_project/features/auth/presentation/pages/send_email_otp_page.dart';
import 'package:college_project/sample.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class AppRoutes extends StatelessWidget {
  const AppRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Community Study',
      theme: CupertinoThemeData(primaryColor: CupertinoColors.activeBlue),
      initialRoute: '/',
      routes: {
        // '/': (context) => MySampleScreen(),
        '/': (context) => BlocProvider(
          create: (_) => LoginBloc(
            LoginUser(
              AuthRepositoryImpl(
                AuthRemoteDataSource(http.Client(), dotenv.get('API_BASE_URL')),
              ),
            ),
          ),
          child: LoginPage(),
        ),
        '/send-email-otp': (context) => SendEmailOtpPage(),
        '/dashboard': (context) => MySampleScreen(),
      },
    );
  }
}
