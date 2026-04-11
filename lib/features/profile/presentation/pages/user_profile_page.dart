import 'package:college_project/core/services/dio_client.dart';
import 'package:college_project/core/utils/enums/sliding_tab_enum.dart';
import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/core/widgets/avatar_image_widget.dart';
import 'package:college_project/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:college_project/features/posts/data/repositories/post_repositories_impl.dart';
import 'package:college_project/features/posts/domain/usecase/search_posts.dart';
import 'package:college_project/features/posts/presentation/bloc/fetch_posts_bloc/fetch_posts_bloc.dart';
import 'package:college_project/features/posts/presentation/bloc/fetch_posts_bloc/fetch_posts_event.dart';
import 'package:college_project/features/posts/presentation/widget/community_post_item_widget.dart';
import 'package:college_project/features/profile/domain/repositories/profile_repositories.dart';
import 'package:college_project/features/profile/domain/usecase/profile_user.dart';
import 'package:college_project/features/profile/presentation/bloc/get_profile_bloc/get_profile_bloc.dart';
import 'package:college_project/features/profile/presentation/bloc/get_profile_bloc/get_profile_event.dart';
import 'package:college_project/features/profile/presentation/bloc/get_profile_bloc/get_profile_state.dart';
import 'package:college_project/features/profile/presentation/pages/update_user_profile_page.dart';
import 'package:college_project/features/profile/presentation/widgets/comments_container_widget.dart';
import 'package:college_project/features/profile/presentation/widgets/posts_container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final SecureStorageService storageService = SecureStorageService();
  late DioClient dioClient = DioClient(storageService);

  late String userId = '';
  SlidingTabEnum slidingTabEnum = SlidingTabEnum.posts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  void getUserId() async {
    final id = await SecureStorageService().getUserId();
    setState(() {
      userId = id!;
    });
  }

  void reload() {
    context.read<GetProfileBloc>().add(RetryLoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    // print(userId);
    return BlocBuilder<GetProfileBloc, GetProfileState>(
      builder: (context, state) {
        if (state is GetProfileLoading) {
          return Center(child: CupertinoActivityIndicator());
        } else if (state is GetProfileLoaded) {
          final userData = state.profileResultModel;

          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('${userData.username}'),
              leading: userId == userData.userId
                  ? CupertinoButton(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'Edit',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushNamed('/update-profile', arguments: reload);
                      },
                    )
                  : null,
              trailing: userId == userData.userId
                  ? CupertinoButton(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'Settings',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pushNamedAndRemoveUntil(
                            '/settings-profile',
                            (route) => true,
                            arguments: userData.username,
                          );
                        });
                      },
                    )
                  : null,
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AvatarImageWidget(imgUrl: userData.profileImageUrl ?? ''),
                    Column(
                      children: [
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              '${userData.name}',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ?userData.pronoun != null
                                ? Text(
                                    " ${userData.pronoun}??''",
                                    style: TextStyle(
                                      color: CupertinoColors.secondaryLabel
                                          .resolveFrom(context),
                                    ),
                                  )
                                : null,
                            Spacer(),
                          ],
                        ),

                        ?userData.bio != null && userData.bio!.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Text(
                                  userData.bio ?? 'bio',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    // fontSize: 16,
                                    // fontWeight: FontWeight.bold,
                                    color: CupertinoColors.secondaryLabel
                                        .resolveFrom(context),
                                  ),
                                ),
                              )
                            : null,
                      ],
                    ),

                    SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          spacing: 16,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 70,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),

                                  border: BoxBorder.all(
                                    width: 1,
                                    color: CupertinoColors.separator
                                        .resolveFrom(context),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              // color: CupertinoColors
                                              //     .secondaryLabel
                                              //     .resolveFrom(context),
                                              fontSize: 26,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Contributions',
                                        style: TextStyle(
                                          color: CupertinoColors.secondaryLabel
                                              .resolveFrom(context),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CupertinoSlidingSegmentedControl<SlidingTabEnum>(
                          groupValue: slidingTabEnum,
                          children: <SlidingTabEnum, Widget>{
                            SlidingTabEnum.posts: Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                // horizontal: 18,
                                vertical: 10,
                              ),
                              child: Text('Posts'),
                            ),
                            SlidingTabEnum.comments: Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                // horizontal: 18,
                                vertical: 10,
                              ),
                              child: Text('Comments'),
                            ),
                            // SlidingTabEnum.about: Padding(
                            //   padding: EdgeInsetsGeometry.symmetric(
                            //     horizontal: 18,
                            //     vertical: 10,
                            //   ),
                            //   child: Text('About'),
                            // ),
                          },
                          onValueChanged: (value) {
                            if (value != null) {
                              setState(() {
                                slidingTabEnum = value;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 0.5,
                            color: CupertinoColors.separator.resolveFrom(
                              context,
                            ),
                          ),
                          Expanded(
                            child: IndexedStack(
                              index: slidingTabEnum.index,
                              children: [
                                BlocProvider(
                                  create: (_) => FetchPostsBloc(
                                    SearchPosts(
                                      PostRepositoriesImpl(
                                        PostsRemoteDataSource(dioClient.dio),
                                      ),
                                    ),
                                  )..add(FetchUserPosts(userId: userId)),
                                  child: CommunityPostItemWidget(
                                    key: PageStorageKey('userFeed'),
                                    isCommunity: false,
                                  ),
                                ),
                                // PostsContainerWidget(),
                                CommentsContainerWidget(),
                                // Center(child: Text('Posts')),
                                // Center(child: Text('Comments')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is GetProfileError) {
          return Center(
            child: Column(
              spacing: 8,
              children: [
                Spacer(),
                Text('Something went wrong!'),
                CupertinoButton.filled(
                  sizeStyle: CupertinoButtonSize.medium,
                  child: Text('Retry'),
                  onPressed: () {
                    context.read<GetProfileBloc>().add(RetryLoadProfile());
                  },
                ),
                Spacer(),
              ],
            ),
          );
        }

        return Center(
          // child: Column(
          //   spacing: 8,
          //   children: [
          //     Spacer(),
          //     Text('Something went wrong!'),
          //     CupertinoButton.filled(
          //       sizeStyle: CupertinoButtonSize.medium,
          //       child: Text('Retry'),
          //       onPressed: () {
          //         context.read<GetProfileBloc>().add(RetryLoadProfile());
          //       },
          //     ),
          //     Spacer(),
          //   ],
          // ),
        );
      },
    );
  }
}
