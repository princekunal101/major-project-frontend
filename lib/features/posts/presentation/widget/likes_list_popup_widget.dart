import 'package:college_project/features/posts/presentation/bloc/fetch_post_reaction_bloc/fetch_post_reaction_bloc.dart';
import 'package:college_project/features/posts/presentation/bloc/fetch_post_reaction_bloc/fetch_post_reaction_state.dart';
import 'package:college_project/features/posts/presentation/bloc/posts_reaction_bloc/post_reaction_state.dart'
    hide PostReactionLoading;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikesListPopupWidget extends StatelessWidget {
  final String postId;
  final int likeCounts;

  const LikesListPopupWidget({
    super.key,
    required this.postId,
    required this.likeCounts,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,

      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.7,
        maxChildSize: 0.9,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground.resolveFrom(context),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),

              child: BlocBuilder<FetchPostReactionBloc, FetchPostReactionState>(
                builder: (context, state) {
                  if (state is PostReactionLoading) {
                    return Center(child: CupertinoActivityIndicator());
                  }

                  if (state is PostReactionFailure) {
                    return Center(child: Text('Something went wrong!'));
                  }

                  // if (state is PostReactionCountLoaded) {
                  //
                  //   likeCount = state.likeCount;
                  // }
                  if (state is PostReactionLoaded) {
                    final likedUser = state.responseModel;
                    final likeCount = state.likeCount;

                    // if (likedUser.users.isEmpty) {
                    //   return Center(
                    //     child: Column(
                    //       children: [
                    //         Spacer(),
                    //         Icon(
                    //           CupertinoIcons.heart_slash_circle,
                    //           size: 100,
                    //           color: CupertinoColors.tertiaryLabel.resolveFrom(
                    //             context,
                    //           ),
                    //         ),
                    //         Text(
                    //           'No Likes Yet!',
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             color: CupertinoColors.secondaryLabel
                    //                 .resolveFrom(context),
                    //           ),
                    //         ),
                    //         Spacer(),
                    //       ],
                    //     ),
                    //   );
                    // }
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Container(
                              height: 5,
                              width: 40,
                              decoration: BoxDecoration(
                                color: CupertinoColors.separator.resolveFrom(
                                  context,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'All Likes ($likeCount)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          height: 0.5,
                          width: double.infinity,
                          color: CupertinoColors.separator.resolveFrom(context),
                        ),

                        // CupertinoListSection(
                        // children: [
                        // CupertinoListTile.notched(
                        // title: Text('u/${likedUser.users} (User Name)'),
                        // leading: Container(
                        // height: 30,
                        // width: 30,
                        // decoration: BoxDecoration(
                        // borderRadius: BorderRadius.all(
                        // Radius.circular(15),
                        // ),
                        // color: CupertinoColors.systemGrey3,
                        // ),
                        // ),
                        // subtitle: Text(
                        // 'Chalo Bahiya main kya kr sakta hu?',
                        // ),
                        // trailing: CupertinoListTileChevron(),
                        // ),
                        // ],
                        // ),

                        /// If NUll then to show the empty container
                        Expanded(
                          child: likedUser.users.isEmpty
                              ? Center(
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Icon(
                                        CupertinoIcons.heart_slash_circle,
                                        size: 100,
                                        color: CupertinoColors.tertiaryLabel
                                            .resolveFrom(context),
                                      ),
                                      Text(
                                        'No Likes Yet!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: CupertinoColors.secondaryLabel
                                              .resolveFrom(context),
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  // controller: scrollController,
                                  shrinkWrap: true,
                                  itemCount: likedUser.users.length,
                                  itemBuilder: (context, index) {
                                    final user = likedUser.users[index];
                                    return CupertinoListTile.notched(
                                      title: Text('u/${user.username}'),
                                      leading: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          color: CupertinoColors.systemGrey3,
                                        ),
                                      ),
                                      subtitle: Text(
                                        user.reactType,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: CupertinoListTileChevron(),
                                      onTap: (){

                                      },
                                    );
                                  },
                                ),
                          //       : Center(
                          //           child: Column(
                          //             children: [
                          //               Spacer(),
                          //               Icon(
                          //                 CupertinoIcons.heart_slash_circle,
                          //                 size: 100,
                          //                 color: CupertinoColors.tertiaryLabel
                          //                     .resolveFrom(context),
                          //               ),
                          //               Text(
                          //                 'No Likes Yet!',
                          //                 style: TextStyle(
                          //                   fontWeight: FontWeight.bold,
                          //                   color: CupertinoColors.secondaryLabel
                          //                       .resolveFrom(context),
                          //                 ),
                          //               ),
                          //               Spacer(),
                          //             ],
                          //           ),
                          //         ),
                        ),
                      ],
                    );
                  }

                  return Center(child: Text('No liked yet'));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
