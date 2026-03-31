import 'package:college_project/core/utils/pinned_header_delegate.dart';
import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_bloc.dart';
import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_event.dart';
import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_state.dart';
import 'package:college_project/features/feed/presentation/widgets/community_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final ScrollController _controller = ScrollController();

  final TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isSubmitted = false;

  // bool _ShowNavBar = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller.addListener(() {
    //   if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
    //     if (_ShowNavBar) {
    //       setState(() {
    //         _ShowNavBar = false;
    //       });
    //     }
    //   } else if (_controller.position.userScrollDirection ==
    //       ScrollDirection.forward) {
    //     if (!_ShowNavBar) {
    //       setState(() {
    //         _ShowNavBar = true;
    //       });
    //     }
    //   }
    // });
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
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _focusNode.addListener(() {
    //   if (!_focusNode.hasFocus) {
    //     if (_isSubmitted) {
    //       _isSubmitted = false;
    //     } else {
    //       searchController.clear();
    //       print('Cancel button clicked');
    //       // context.read<SearchCommunityBloc>().add(SearchCommunityInitial());
    //     }
    //   }
    // });
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Feed'),

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
                ).pushNamedAndRemoveUntil(
                  '/search-widget-page',
                  (route) => true,
                );
                // });
              },
            ),
          ),

          // SliverPersistentHeader(delegate: delegate)
          BlocBuilder<SearchCommunityBloc, SearchCommunityState>(
            builder: (context, state) {
              if (state is SearchCommunityLoading) {}

              if (state is SearchCommunityFailure) {
                return SliverFillRemaining(
                  child: Center(child: Text(state.message)),
                );
              }

              if (state is SearchCommunityLoaded) {
                final searchList = state.responseModel;
                return SliverToBoxAdapter(
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
              return SliverSafeArea(
                top: false,
                sliver: SliverList(

                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Text('Post DataFound! $index'),

                    childCount: 50,
                  ),
                ),
              );
              return SliverFillRemaining(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('🧑‍💻', style: TextStyle(fontSize: 34)),
                    Text('On Progress!'),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
