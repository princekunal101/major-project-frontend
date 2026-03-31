import 'package:college_project/core/services/dio_client.dart';
import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/core/themes/my_cupertino_theme.dart';
import 'package:college_project/core/utils/enums/community_shared_value.dart';
import 'package:college_project/core/utils/enums/community_topic.dart';
import 'package:college_project/core/utils/enums/community_type.dart';
import 'package:college_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:college_project/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:college_project/features/auth/domain/usecase/accepted_terms.dart';
import 'package:college_project/features/auth/domain/usecase/forgotten_password.dart';
import 'package:college_project/features/auth/domain/usecase/login_user.dart';
import 'package:college_project/features/auth/domain/usecase/resend_otp.dart';
import 'package:college_project/features/auth/domain/usecase/set_dob.dart';
import 'package:college_project/features/auth/domain/usecase/set_forgot_new_password.dart';
import 'package:college_project/features/auth/domain/usecase/set_full_name.dart';
import 'package:college_project/features/auth/domain/usecase/set_password.dart';
import 'package:college_project/features/auth/domain/usecase/set_username.dart';
import 'package:college_project/features/auth/domain/usecase/signup_with_email.dart';
import 'package:college_project/features/auth/domain/usecase/verify_forgot_password_otp.dart';
import 'package:college_project/features/auth/domain/usecase/verify_otp.dart';
import 'package:college_project/features/auth/presentation/bloc/accepted_terms_bloc/accepted_terms_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/email_signup_bloc/email_signup_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/forgotten_password_bloc/forgotten_password_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/set_dob_bloc/set_dob_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/set_forgot_new_password_bloc/set_forgot_new_password_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/set_full_name_bloc/set_full_name_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/set_password_bloc/set_password_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/set_username_bloc/set_username_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/verify_forgotten_password_otp_bloc/verify_forgotten_password_otp_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:college_project/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:college_project/features/auth/presentation/pages/login_page.dart';
import 'package:college_project/features/auth/presentation/pages/set_dob_page.dart';
import 'package:college_project/features/auth/presentation/pages/set_forgot_new_password_page.dart';
import 'package:college_project/features/auth/presentation/pages/set_full_name_page.dart';
import 'package:college_project/features/auth/presentation/pages/set_password_page.dart';
import 'package:college_project/features/auth/presentation/pages/set_username_page.dart';
import 'package:college_project/features/auth/presentation/pages/signup_with_email_page.dart';
import 'package:college_project/features/auth/presentation/pages/term_policy_page.dart';
import 'package:college_project/features/auth/presentation/pages/verify_email_otp_page.dart';
import 'package:college_project/features/auth/presentation/pages/verify_forgot_password_otp_page.dart';
import 'package:college_project/dashboard_tab_navigation.dart';
import 'package:college_project/features/community/data/datasources/community_remote_data_source.dart';
import 'package:college_project/features/community/data/repoitories/community_repository_impl.dart';
import 'package:college_project/features/community/domain/usecase/create_community.dart';
import 'package:college_project/features/community/domain/usecase/get_community.dart';
import 'package:college_project/features/community/presentation/bloc/create_community_bloc/create_community_bloc.dart';
import 'package:college_project/features/community/presentation/bloc/get_community_bloc/get_community_bloc.dart';
import 'package:college_project/features/community/presentation/bloc/get_community_bloc/get_community_event.dart';
import 'package:college_project/features/community/presentation/pages/about_community_page.dart';
import 'package:college_project/features/community/presentation/pages/community_details_page.dart';
import 'package:college_project/features/community/presentation/pages/community_page.dart';
import 'package:college_project/features/community/presentation/pages/community_type_page.dart';
import 'package:college_project/features/feed/data/datasources/feed_remote_data_source.dart';
import 'package:college_project/features/feed/data/repositories/feed_repository_impl.dart';
import 'package:college_project/features/feed/domain/usecase/get_community_lists.dart';
import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_bloc.dart';
import 'package:college_project/features/feed/presentation/pages/search_widget_page.dart';
import 'package:college_project/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:college_project/features/posts/data/repositories/post_repositories_impl.dart';
import 'package:college_project/features/posts/domain/usecase/search_posts.dart';
import 'package:college_project/features/posts/presentation/bloc/search_posts_bloc/search_posts_bloc.dart';
import 'package:college_project/features/posts/presentation/pages/search_posts_page.dart';
import 'package:college_project/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:college_project/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:college_project/features/profile/domain/usecase/change_password.dart';
import 'package:college_project/features/profile/domain/usecase/profile_user.dart';
import 'package:college_project/features/profile/domain/usecase/update_profile.dart';
import 'package:college_project/features/profile/presentation/bloc/change_password_bloc/change_password_bloc.dart';
import 'package:college_project/features/profile/presentation/bloc/get_profile_bloc/get_profile_bloc.dart';
import 'package:college_project/features/profile/presentation/bloc/get_profile_bloc/get_profile_event.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:college_project/features/profile/presentation/pages/change_password_page.dart';
import 'package:college_project/features/profile/presentation/pages/settings_profile_page.dart';
import 'package:college_project/features/profile/presentation/pages/update_user_profile_page.dart';
import 'package:college_project/features/profile/presentation/pages/user_profile_page.dart';
import 'package:college_project/features/profile/presentation/widgets/update_name_widget.dart';
import 'package:college_project/unknown_page.dart';
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class AppRoutes extends StatelessWidget {
  final bool isLogin;
  final SecureStorageService storage;
  final DioClient dioClient;

  const AppRoutes({
    super.key,
    required this.isLogin,
    required this.storage,
    required this.dioClient,
  });

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
            ? DashboardTabNavigation()
            // BlocProvider(
            //   create: (_) => GetProfileBloc(
            //     ProfileUser(
            //       ProfileRepositoryImpl(
            //         ProfileRemoteDataSource(
            //           Dio(BaseOptions(baseUrl: dotenv.get('API_BASE_URL'))),
            //         ),
            //       ),
            //     ),
            //   )..add(LoadProfile()),
            //   child: UserProfilePage(),
            // )
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

        '/forgot-password': (context) => BlocProvider(
          create: (_) => ForgottenPasswordBloc(
            ForgottenPassword(
              AuthRepositoryImpl(
                AuthRemoteDataSource(http.Client(), dotenv.get('API_BASE_URL')),
                storage,
              ),
            ),
          ),
          child: ForgotPasswordPage(),
        ),

        '/dashboard': (context) => DashboardTabNavigation(),
        '/profile': (context) => BlocProvider(
          create: (_) => GetProfileBloc(
            ProfileUser(
              ProfileRepositoryImpl(ProfileRemoteDataSource(dioClient.dio)),
            ),
          )..add(LoadProfile()),
          child: UserProfilePage(),
        ),

        '/create-community': (context) => AboutCommunityPage(),
        '/search-widget-page': (context) => BlocProvider(
          create: (_) => SearchCommunityBloc(
            GetCommunityLists(
              FeedRepositoryImpl(FeedRemoteDataSource(dioClient.dio)),
            ),
          ),
          child: SearchWidgetPage(),
        ),
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
            return CupertinoPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => SetDobBloc(
                  SetDob(
                    AuthRepositoryImpl(
                      AuthRemoteDataSource(
                        http.Client(),
                        dotenv.get('API_BASE_URL'),
                      ),
                      storage,
                    ),
                  ),
                ),
                child: SetDobPage(userId: args),
              ),
            );

          case '/set-name':
            final args = settings.arguments as String;
            return CupertinoPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => SetFullNameBloc(
                  SetFullName(
                    AuthRepositoryImpl(
                      AuthRemoteDataSource(
                        http.Client(),
                        dotenv.get('API_BASE_URL'),
                      ),
                      storage,
                    ),
                  ),
                ),
                child: SetFullNamePage(userId: args),
              ),
            );

          case '/set-username':
            final args = settings.arguments as String;
            return CupertinoPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => SetUsernameBloc(
                  SetUsername(
                    AuthRepositoryImpl(
                      AuthRemoteDataSource(
                        http.Client(),
                        dotenv.get('API_BASE_URL'),
                      ),
                      storage,
                    ),
                  ),
                ),
                child: SetUsernamePage(userId: args),
              ),
            );

          case '/term-policy':
            final args = settings.arguments as String;
            return CupertinoPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => AcceptedTermsBloc(
                  AcceptedTerms(
                    AuthRepositoryImpl(
                      AuthRemoteDataSource(
                        http.Client(),
                        dotenv.get('API_BASE_URL'),
                      ),
                      storage,
                    ),
                  ),
                ),
                child: TermPolicyPage(userId: args),
              ),
            );

          case '/verify-otp-forget-password':
            final args = settings.arguments as String;
            return CupertinoPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => VerifyForgottenPasswordOtpBloc(
                  VerifyForgotPasswordOtp(
                    AuthRepositoryImpl(
                      AuthRemoteDataSource(
                        http.Client(),
                        dotenv.get('API_BASE_URL'),
                      ),
                      storage,
                    ),
                  ),
                ),
                child: VerifyForgotPasswordOtpPage(emailId: args),
              ),
            );

          case '/set-new-password':
            final args = settings.arguments as String;
            return CupertinoPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => SetForgotNewPasswordBloc(
                  SetForgotNewPassword(
                    AuthRepositoryImpl(
                      AuthRemoteDataSource(
                        http.Client(),
                        dotenv.get('API_BASE_URL'),
                      ),
                      storage,
                    ),
                  ),
                ),
                child: SetForgotNewPasswordPage(email: args),
              ),
            );

          case '/update-profile':
            final args = settings.arguments as VoidCallback;
            return CupertinoPageRoute(
              builder: (context) => BlocProvider(
                create: (_) => GetProfileBloc(
                  ProfileUser(
                    ProfileRepositoryImpl(
                      ProfileRemoteDataSource(dioClient.dio),
                    ),
                  ),
                )..add(LoadProfile()),
                child: UpdateUserProfilePage(reload: args),
              ),
            );
          case '/update-name':
            final args = settings.arguments as String;
            return CupertinoPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => UpdateProfileBloc(
                  UpdateProfile(
                    ProfileRepositoryImpl(
                      ProfileRemoteDataSource(dioClient.dio),
                    ),
                  ),
                ),
                child: UpdateNameWidget(name: args),
              ),
            );

          case '/settings-profile':
            final args = settings.arguments as String;
            return CupertinoPageRoute(
              builder: (_) => SettingsProfilePage(username: args),
            );

          case '/change-password':
            final args = settings.arguments as String;
            return CupertinoPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => ChangePasswordBloc(
                  ChangePassword(
                    ProfileRepositoryImpl(
                      ProfileRemoteDataSource(dioClient.dio),
                    ),
                  ),
                ),
                child: ChangePasswordPage(username: args),
              ),
            );
          case '/community-type':
            final args = settings.arguments as Map<String, dynamic>;
            return CupertinoPageRoute(
              builder: (_) => CommunityTypePage(
                topic: args['topic'] as CommunityTopic,
                sharedValue: args['sharedValue'] as CommunitySharedValue,
              ),
            );

          case '/community-details':
            final args = settings.arguments as Map<String, dynamic>;
            return CupertinoPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => CreateCommunityBloc(
                  CreateCommunity(
                    CommunityRepositoryImpl(
                      CommunityRemoteDataSource(dioClient.dio),
                    ),
                  ),
                ),
                child: CommunityDetailsPage(
                  topic: args['topic'] as CommunityTopic,
                  sharedValue: args['sharedValue'] as CommunitySharedValue,
                  communityType: args['communityType'] as CommunityType,
                ),
              ),
            );
          case '/community-page':
            final args = settings.arguments as Map<String, String>;
            return CupertinoPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => GetCommunityBloc(
                  GetCommunity(
                    CommunityRepositoryImpl(
                      CommunityRemoteDataSource(dioClient.dio),
                    ),
                  ),
                )..add(GetCommunityResultLoad(args['communityId'] as String)),
                child: CommunityPage(
                  communityName: args['communityName'] as String,
                  communityId: args['communityId'] as String,
                ),
              ),
            );

          case '/search-posts-page':
            final args = settings.arguments as String;
            return CupertinoPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => SearchPostsBloc(
                  SearchPosts(
                    PostRepositoriesImpl(PostsRemoteDataSource(dioClient.dio)),
                  ),
                ),
                child: SearchPostsPage(communityId: args),
              ),
            );

          default:
            return CupertinoPageRoute(builder: (_) => UnknownPage());
        }
      },
    );
  }
}
