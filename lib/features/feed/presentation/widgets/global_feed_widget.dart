import 'package:college_project/features/feed/presentation/bloc/feed_bloc/feed_bloc.dart';
import 'package:college_project/features/feed/presentation/bloc/feed_bloc/feed_event.dart';
import 'package:college_project/features/feed/presentation/bloc/feed_bloc/feed_state.dart';
import 'package:college_project/features/posts/presentation/widget/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalFeedWidget extends StatefulWidget {
  const GlobalFeedWidget({super.key});

  @override
  State<GlobalFeedWidget> createState() => _UserFeedWidgetState();
}

class _UserFeedWidgetState extends State<GlobalFeedWidget>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

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

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CupertinoScrollbar(
      controller: _scrollController,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              context.read<FeedBloc>().add(ReloadFeed());
            },
          ),

          BlocBuilder<FeedBloc, FeedState>(
            builder: (context, state) {
              if (state is FeedLoading) {
                return SliverFillRemaining(
                  child: Center(child: CupertinoActivityIndicator()),
                );
              } else if (state is FeedFailure) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      spacing: 8,
                      children: [
                        Spacer(),
                        Text('Something went wrong!${state.message}'),
                        CupertinoButton.filled(
                          sizeStyle: CupertinoButtonSize.medium,
                          child: Text('Retry'),
                          onPressed: () {
                            context.read<FeedBloc>().add(ReloadFeed());
                          },
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                );
              } else if (state is FeedLoaded || state is FeedLoadingNext) {
                final model = (state as dynamic).responseModel;
                // return ListView.builder(
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < model.listItem.length) {
                        final post = model.listItem[index];
                        return PostWidget(
                          id: post.id,
                          username: post.username,
                          communityName: post.communityName,
                          userImg: post.userImg,
                          title: post.title,
                          subTitle: post.subTitle,
                          body: post.body,
                          summaryTitle: post.summaryTitle,
                          summaryBody: post.summary,
                          isFollowing: post.isFollowing,
                          createdAt: post.createdAt,
                          isLikedByMe: post.isLikedByMe,
                          onLikeButtonPress: (){
                            context.read<FeedBloc>().add(
                              ToggleLikes(post.id, post.isLikedByMe),
                            );
                          },
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CupertinoActivityIndicator(),
                        );
                      }
                    },
                    childCount: model.listItem.length + (model.hasMore ? 1 : 0),
                  ),
                );
              }
              return SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
