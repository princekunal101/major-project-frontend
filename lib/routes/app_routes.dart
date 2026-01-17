import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/core/themes/my_cupertino_theme.dart';
import 'package:college_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:college_project/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:college_project/features/auth/domain/usecase/login_user.dart';
import 'package:college_project/features/auth/domain/usecase/resend_otp.dart';
import 'package:college_project/features/auth/domain/usecase/set_password.dart';
import 'package:college_project/features/auth/domain/usecase/signup_with_email.dart';
import 'package:college_project/features/auth/domain/usecase/verify_otp.dart';
import 'package:college_project/features/auth/presentation/bloc/email_signup_bloc/email_signup_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/set_password_bloc/set_password_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:college_project/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:college_project/features/auth/presentation/pages/login_page.dart';
import 'package:college_project/features/auth/presentation/pages/set_dob_page.dart';
import 'package:college_project/features/auth/presentation/pages/set_password_page.dart';
import 'package:college_project/features/auth/presentation/pages/signup_with_email_page.dart';
import 'package:college_project/features/auth/presentation/pages/verify_email_otp_page.dart';
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
        '/signup-with-email': (context) => BlocProvider(
          create: (_) => EmailSignupBloc(
            SignupWithEmail(
              AuthRepositoryImpl(
                AuthRemoteDataSource(http.Client(), dotenv.get('API_BASE_URL')),
                storage,
              ),
            ),
          ),
          child: SignupWithEmailPage(),
        ),

        '/forgot-password': (context) => ForgotPasswordPage(),
        '/dashboard': (context) => MySampleScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/verify-email-otp':
            final args = settings.arguments as String;
            return CupertinoPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) => VerifyOtpBloc(
                      VerifyOtp(
                        AuthRepositoryImpl(
                          AuthRemoteDataSource(
                            http.Client(),
                            dotenv.get('API_BASE_URL'),
                          ),
                          storage,
                        ),
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (_) => ResendOtpBloc(
                      ResendOtp(
                        AuthRepositoryImpl(
                          AuthRemoteDataSource(
                            http.Client(),
                            dotenv.get('API_BASE_URL'),
                          ),
                          storage,
                        ),
                      ),
                    ),
                  ),
                ],
                child: VerifyEmailOtpPage(email: args),
              ),
            );
          case '/set-password':
            final args = settings.arguments as String;
            return CupertinoPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => SetPasswordBloc(
                  SetPassword(
                    AuthRepositoryImpl(
                      AuthRemoteDataSource(
                        http.Client(),
                        dotenv.get('API_BASE_URL'),
                      ),
                      storage,
                    ),
                  ),
                ),
                child: SetPasswordPage(email: args),
              ),
            );
          case '/set-dob':
            final args = settings.arguments as String;
            return CupertinoPageRoute(builder: (_) => SetDobPage(userId: args));

          default:
            return null;
        }
      },
    );
  }
}
