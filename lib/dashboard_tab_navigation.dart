import 'package:college_project/core/services/dio_client.dart';
import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/features/feed/data/datasources/feed_remote_data_source.dart';
import 'package:college_project/features/feed/data/repositories/feed_repository_impl.dart';
import 'package:college_project/features/feed/domain/usecase/get_all_posts_lists.dart';
import 'package:college_project/features/feed/domain/usecase/get_community_lists.dart';
import 'package:college_project/features/feed/domain/usecase/get_user_feeds_lists.dart';
import 'package:college_project/features/feed/presentation/bloc/feed_bloc/feed_bloc.dart';
import 'package:college_project/features/feed/presentation/bloc/feed_bloc/feed_event.dart';
import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_bloc.dart';
import 'package:college_project/features/feed/presentation/pages/feed_page.dart';
import 'package:college_project/features/posts/presentation/pages/create_new_post_page.dart';
import 'package:college_project/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:college_project/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:college_project/features/profile/domain/usecase/profile_user.dart';
import 'package:college_project/features/profile/presentation/bloc/get_profile_bloc/get_profile_bloc.dart';
import 'package:college_project/features/profile/presentation/bloc/get_profile_bloc/get_profile_event.dart';
import 'package:college_project/features/profile/presentation/pages/user_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardTabNavigation extends StatefulWidget {
  const DashboardTabNavigation({super.key});

  @override
  State<DashboardTabNavigation> createState() => _DashboardTabNavigationState();
}

class _DashboardTabNavigationState extends State<DashboardTabNavigation> {
  final storage = SecureStorageService();
  late final dioClient = DioClient(storage);

  final CupertinoTabController _controller = CupertinoTabController();

  int _currentIndex = 0;

  void _onTabTapped(int index) {
    if (index == 1) {
      // Future.microtask(() {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => CreateNewPostPage(),
        //     BlocProvider<UpdateProfileBloc>(
        //   create: (_) => UpdateProfileBloc(
        //     UpdateProfile(
        //       ProfileRepositoryImpl(
        //         ProfileRemoteDataSource(dioClient.dio),
        //       ),
        //     ),
        //   ),
        //   child: UpdateGenderWidget(
        //     gender: userData.gender ?? '',
        //   ),
        // ),
        // );
      ).then((_) {
        setState(() {
          _controller.index = _currentIndex;
        });
      });
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: _controller,
      tabBar: CupertinoTabBar(
        // currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_3_fill),
            label: 'Communities',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add),
            label: 'Create Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_crop_circle),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<SearchCommunityBloc>(
                    create: (_) => SearchCommunityBloc(
                      GetCommunityLists(
                        FeedRepositoryImpl(FeedRemoteDataSource(dioClient.dio)),
                      ),
                    ),
                  ),
                ],
                child: FeedPage(),
              ),
            );
          // return CupertinoTabView(builder: (_) => FeedPage());
          case 2:
            return CupertinoTabView(
              builder: (_) => BlocProvider(
                create: (_) => GetProfileBloc(
                  ProfileUser(
                    ProfileRepositoryImpl(
                      ProfileRemoteDataSource(dioClient.dio),
                    ),
                  ),
                )..add(LoadProfile()),
                child: UserProfilePage(),
              ),
            );
          default:
            return CupertinoTabView(builder: (_) => SizedBox.shrink());
        }
      },
    );
  }
}
