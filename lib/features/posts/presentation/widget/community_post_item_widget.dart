import 'package:college_project/features/feed/presentation/bloc/feed_bloc/feed_bloc.dart';
import 'package:college_project/features/feed/presentation/bloc/feed_bloc/feed_event.dart';
import 'package:college_project/features/feed/presentation/bloc/feed_bloc/feed_state.dart';
import 'package:college_project/features/posts/domain/entities/search_posts_params.dart';
import 'package:college_project/features/posts/presentation/bloc/fetch_posts_bloc/fetch_posts_bloc.dart';
import 'package:college_project/features/posts/presentation/bloc/fetch_posts_bloc/fetch_posts_event.dart';
import 'package:college_project/features/posts/presentation/bloc/fetch_posts_bloc/fetch_posts_state.dart';
import 'package:college_project/features/posts/presentation/widget/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityPostItemWidget extends StatefulWidget {
  final bool isCommunity;

  const CommunityPostItemWidget({super.key, this.isCommunity = true});

  @override
  State<CommunityPostItemWidget> createState() => _CommunityPostItemWidget();
}

class _CommunityPostItemWidget extends State<CommunityPostItemWidget>
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
      final bloc = context.read<FetchPostsBloc>();
      final state = bloc.state;
      if (state is FetchPostLoaded &&
          state.responseModel.hasMore &&
          state.responseModel.nextCursor != null) {
        bloc.add(
          LoadNextPosts(state.originalEvent, state.responseModel.nextCursor!),
        );
      }
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
              final bloc = context.read<FetchPostsBloc>();
              final state = bloc.state;
              if (state is FetchPostLoaded) {
                bloc.add(ReloadPosts(state.originalEvent));
              }
            },
          ),

          BlocBuilder<FetchPostsBloc, FetchPostsState>(
            builder: (context, state) {
              if (state is FetchPostLoading) {
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
                        Text('Something went wrong!'),
                        CupertinoButton.filled(
                          sizeStyle: CupertinoButtonSize.medium,
                          child: Text('Retry'),
                          onPressed: () {
                            final bloc = context.read<FetchPostsBloc>();
                            final state = bloc.state;
                            if (state is FetchPostLoaded) {
                              context.read<FetchPostsBloc>().add(
                                ReloadPosts(state.originalEvent),
                              );
                            }
                          },
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                );
              } else if (state is FetchPostLoaded || state is LoadNextPosts) {
                final model = (state as dynamic).responseModel;
                // return ListView.builder(
                if (model.list.isEmpty || model.list == null) {
                  return SliverFillRemaining(
                    child: widget.isCommunity
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 8,
                                children: [
                                  Icon(
                                    CupertinoIcons.pencil_outline,
                                    size: 100,
                                  ),
                                  Text(
                                    'Community don\'t have any posts',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'When anyone create a post this community, it will appear here.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: CupertinoColors.secondaryLabel
                                          .resolveFrom(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 8,
                                children: [
                                  Icon(
                                    CupertinoIcons.pencil_outline,
                                    size: 100,
                                  ),
                                  Text(
                                    'You don\'t have any posts',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'When you create a post in a community, it will appear here.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: CupertinoColors.secondaryLabel
                                          .resolveFrom(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index < model.list.length) {
                      final post = model.list[index];
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
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CupertinoActivityIndicator(),
                      );
                    }
                  }, childCount: model.list.length + (model.hasMore ? 1 : 0)),
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
