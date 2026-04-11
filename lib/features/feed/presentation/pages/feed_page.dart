import 'package:college_project/core/services/dio_client.dart';
import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/core/utils/pinned_header_delegate.dart';
import 'package:college_project/features/feed/data/datasources/feed_remote_data_source.dart';
import 'package:college_project/features/feed/data/repositories/feed_repository_impl.dart';
import 'package:college_project/features/feed/domain/usecase/get_all_posts_lists.dart';
import 'package:college_project/features/feed/domain/usecase/get_user_feeds_lists.dart';
import 'package:college_project/features/feed/presentation/bloc/feed_bloc/feed_bloc.dart';
import 'package:college_project/features/feed/presentation/bloc/feed_bloc/feed_event.dart';
import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_bloc.dart';
import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_event.dart';
import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_state.dart';
import 'package:college_project/features/feed/presentation/widgets/community_list_widget.dart';
import 'package:college_project/features/feed/presentation/widgets/global_feed_widget.dart';
import 'package:college_project/features/feed/presentation/widgets/user_feed_widget.dart';
import 'package:college_project/features/posts/presentation/widget/post_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Segment { forYou, following }

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final SecureStorageService storageService = SecureStorageService();
  late DioClient dioClient = DioClient(storageService);

  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final PageController _pageController = PageController();

  Segment _selectedSegment = Segment.forYou;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<FeedBloc>().add(LoadNextFeed());
    }
  }

  void onSubmitSearch() {
    context.read<SearchCommunityBloc>().add(
      SearchCommunityStringSubmitted(
        communityName: searchController.text.trim(),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // largeTitle: Text('Feed'),

        // largeTitle: Text('Community Study'),
        middle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/splash/cs_study_splash_logo.png',
              width: 35,
              height: 35,
            ),
            Text('Community Study'),
          ],
        ),

        // middle: CupertinoSearchTextField(),
        // leading: Image.asset(
        //   'assets/splash/cs_study_splash_logo.png',
        // ),
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Icon(CupertinoIcons.add),
          ),
          onTap: () {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamedAndRemoveUntil('/create-community', (route) => true);
            // });
          },
        ),

        trailing: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Icon(CupertinoIcons.search_circle),
          ),
          onTap: () {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamedAndRemoveUntil('/search-widget-page', (route) => true);
            // });
          },
        ),

        // bottomMode: NavigationBarBottomMode.always,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: double.infinity,
              height: 30,
              // color: CupertinoColors.systemRed,
              child: CupertinoSlidingSegmentedControl<Segment>(
                groupValue: _selectedSegment,
                children: <Segment, Widget>{
                  Segment.forYou: Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
                    child: Text('For You'),
                  ),

                  Segment.following: Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
                    child: Text('Following'),
                  ),
                },
                onValueChanged: (Segment? value) {
                  if (value != null) {
                    setState(() {
                      _selectedSegment = value;
                    });
                    _pageController.animateToPage(
                      value.index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
      child: Column(
        // controller: _scrollController,
        children: <Widget>[
          // SliverPersistentHeader(delegate: delegate)
          BlocBuilder<SearchCommunityBloc, SearchCommunityState>(
            builder: (context, state) {
              if (state is SearchCommunityLoading) {}

              if (state is SearchCommunityFailure) {
                return Center(child: Text(state.message));
              }

              if (state is SearchCommunityLoaded) {
                final searchList = state.responseModel;
                return Container(
                  child: (searchList.listItem.isNotEmpty)
                      ? CupertinoListSection(
                          header: Text('Community'),
                          children: searchList.listItem
                              .map(
                                (item) => CommunityListWidget(
                                  communityId: item.communityId,
                                  displayName: item.displayName,
                                  displayPicUrl: item.displayUrl,
                                  communityName: item.communityName,
                                  totalMember: item.totalMember,
                                  totalPosts: item.totalPosts,
                                ),
                              )
                              .toList(),
                        )
                      : Center(child: Text('No Data Found!')),
                );
              }

              return SizedBox.shrink();
            },
          ),

          // hasScrollBody: false,
          Expanded(
            child: SafeArea(
              // top: false,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedSegment = Segment.values[index];
                  });
                },
                children: [
                  BlocProvider(
                    create: (_) => FeedBloc(
                      GetAllPostsLists(
                        FeedRepositoryImpl(FeedRemoteDataSource(dioClient.dio)),
                      ),
                      GetUserFeedsLists(
                        FeedRepositoryImpl(FeedRemoteDataSource(dioClient.dio)),
                      ),
                    )..add(FetchGlobalFeed()),
                    child: GlobalFeedWidget(key: PageStorageKey('globalFeed')),
                  ),

                  BlocProvider(
                    create: (_) => FeedBloc(
                      GetAllPostsLists(
                        FeedRepositoryImpl(FeedRemoteDataSource(dioClient.dio)),
                      ),
                      GetUserFeedsLists(
                        FeedRepositoryImpl(FeedRemoteDataSource(dioClient.dio)),
                      ),
                    )..add(FetchUserFeed()),
                    child: UserFeedWidget(key: PageStorageKey('userFeed')),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
