import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/core/utils/pinned_header_delegate.dart';
import 'package:college_project/core/widgets/avatar_image_widget.dart';
import 'package:college_project/core/widgets/community_avatar_image_widget.dart';
import 'package:college_project/features/community/presentation/bloc/get_community_bloc/get_community_bloc.dart';
import 'package:college_project/features/community/presentation/bloc/get_community_bloc/get_community_event.dart';
import 'package:college_project/features/community/presentation/bloc/get_community_bloc/get_community_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityPage extends StatefulWidget {
  final String communityName;
  final String communityId;

  const CommunityPage({
    super.key,
    required this.communityName,
    required this.communityId,
  });

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final SecureStorageService storageService = SecureStorageService();
  late String userId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUserId();
  }

  void initUserId() async {
    final value = (await storageService.getUserId())!;
    setState(() {
      userId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      // navigationBar: CupertinoNavigationBar(
      //   // backgroundColor: CupertinoColors.destructiveRed,
      //   // automaticBackgroundVisibility: true,
      //   // middle: Text('c/${widget.communityName}'),
      //   trailing: Row(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     spacing: 10,
      //     children: [
      //       CupertinoButton.tinted(
      //         sizeStyle: CupertinoButtonSize.medium,
      //         child: Icon(CupertinoIcons.search),
      //         onPressed: () {},
      //       ),
      //       CupertinoButton.tinted(
      //         sizeStyle: CupertinoButtonSize.medium,
      //         child: Icon(CupertinoIcons.ellipsis_vertical),
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      //   bottom: PreferredSize(
      //     preferredSize: Size.fromHeight(200),
      //     child: Container(color: CupertinoColors.activeGreen),
      //   ),
      //   // trailing: GestureDetector(
      //   //   onTap: () {},
      //   //   child: Padding(
      //   //     padding: const EdgeInsets.all(8.0),
      //   //     child: Icon(CupertinoIcons.ellipsis_vertical),
      //   //   ),
      //   // ),
      //   // trailing: CupertinoButton(
      //   //   sizeStyle: CupertinoButtonSize.medium,
      //   //   child: Icon(CupertinoIcons.ellipsis_vertical),
      //   //   onPressed: () {},
      //   // ),
      // ),
      child: BlocBuilder<GetCommunityBloc, GetCommunityState>(
        builder: (context, state) {
          if (state is GetCommunityLoading) {
            return Center(child: CupertinoActivityIndicator());
          } else if (state is GetCommunityLoaded) {
            final communityData = state.communityResultModel;

            return CustomScrollView(
              slivers: [
                // SliverPersistentHeader(
                //   pinned: true,
                //   delegate: PinnedHeaderDelegate(
                //     child: CupertinoNavigationBar(
                //       // backgroundColor: CupertinoColors.destructiveRed,
                //       // automaticBackgroundVisibility: true,
                //       // middle: Text('c/${widget.communityName}'),
                //       trailing: Row(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         spacing: 10,
                //         children: [
                //           CupertinoButton.tinted(
                //             sizeStyle: CupertinoButtonSize.medium,
                //             child: Icon(CupertinoIcons.search),
                //             onPressed: () {},
                //           ),
                //           CupertinoButton.tinted(
                //             sizeStyle: CupertinoButtonSize.medium,
                //             child: Icon(CupertinoIcons.ellipsis_vertical),
                //             onPressed: () {},
                //           ),
                //         ],
                //       ),
                //
                //     ),
                //     height: 80,
                //   ),
                // ),
                CupertinoSliverNavigationBar(
                  // middle: Text('nothing'),
                  // backgroundColor: CupertinoColors.activeGreen,
                  // alwaysShowMiddle: true,
                  largeTitle: Text('c/${communityData.communityName}'),

                  trailing: CupertinoButton(
                    sizeStyle: CupertinoButtonSize.medium,
                    child: Icon(CupertinoIcons.ellipsis_vertical),
                    onPressed: () {},
                  ),

                  // trailing: Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   spacing: 10,
                  //   children: [
                  //     CupertinoButton.tinted(
                  //       sizeStyle: CupertinoButtonSize.medium,
                  //       child: Icon(CupertinoIcons.search),
                  //       onPressed: () {},
                  //     ),
                  //     CupertinoButton.tinted(
                  //       sizeStyle: CupertinoButtonSize.medium,
                  //       child: Icon(CupertinoIcons.ellipsis_vertical),
                  //       onPressed: () {},
                  //     ),
                  //   ],
                  // ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    spacing: 8.0,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommunityAvatarImageWidget(
                              imgUrl: communityData.displayPicUrl ?? '',
                              avatarRadius: 30,
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  communityData.displayName,
                                  // 'c/${communityData.communityName}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  communityData.postsCount == 0
                                      ? 'No Posts yet'
                                      : '${communityData.postsCount} Total Posts',
                                  style: TextStyle(
                                    color: CupertinoColors.secondaryLabel
                                        .resolveFrom(context),
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '${communityData.totalMember} Members',
                                  style: TextStyle(
                                    color: CupertinoColors.secondaryLabel
                                        .resolveFrom(context),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            userId != communityData.createdBy
                                ? CupertinoButton.filled(
                                    sizeStyle: CupertinoButtonSize.small,
                                    child: Text('Join'),
                                    onPressed: () {},
                                  )
                                : Spacer(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            communityData.description,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          spacing: 8,
                          children: [
                            Container(
                              padding: EdgeInsetsGeometry.symmetric(
                                vertical: 6,
                                horizontal: 16.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                color: CupertinoColors.systemTeal,
                              ),
                              child: Text(
                                communityData.communityTopic,
                                style: TextStyle(color: CupertinoColors.white),
                              ),
                            ),

                            Container(
                              padding: EdgeInsetsGeometry.symmetric(
                                vertical: 6,
                                horizontal: 16.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                color: CupertinoColors.systemOrange,
                              ),
                              child: Text(
                                communityData.sharedValue,
                                style: TextStyle(color: CupertinoColors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsetsGeometry.symmetric(
                      //     vertical: 8.0,
                      //     horizontal: 8.0,
                      //   ),
                      //   width: double.infinity,
                      //   // height: 1,
                      //   color: CupertinoColors.secondarySystemFill.resolveFrom(
                      //     context,
                      //   ),
                      //   child: Text('Posts'),
                      // ),
                      // Text('Community Page is here!'),

                      // SingleChildScrollView(
                      //
                      //   child: Expanded(
                      //     flex: 2,
                      //     child: IndexedStack(
                      //       index: 0,
                      //       children: [
                      //         Center(
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(16.0),
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.center,
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               spacing: 8,
                      //               children: [
                      //                 Icon(CupertinoIcons.pencil_outline, size: 100),
                      //                 Text(
                      //                   'You don\'t have any posts',
                      //                   textAlign: TextAlign.center,
                      //                   style: TextStyle(
                      //                     fontSize: 24,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //                 Text(
                      //                   'When you create a post in a community, it will appear here.',
                      //                   textAlign: TextAlign.center,
                      //                   style: TextStyle(
                      //                     color: CupertinoColors.secondaryLabel
                      //                         .resolveFrom(context),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //         Center(
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(16.0),
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.center,
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               spacing: 8,
                      //               children: [
                      //                 Icon(CupertinoIcons.pencil_outline, size: 100),
                      //                 Text(
                      //                   'You don\'t have any posts',
                      //                   textAlign: TextAlign.center,
                      //                   style: TextStyle(
                      //                     fontSize: 24,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //                 Text(
                      //                   'When you create a post in a community, it will appear here.',
                      //                   textAlign: TextAlign.center,
                      //                   style: TextStyle(
                      //                     color: CupertinoColors.secondaryLabel
                      //                         .resolveFrom(context),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),

                SliverPersistentHeader(
                  pinned: true,
                  delegate: PinnedHeaderDelegate(
                    child: Container(
                      padding: EdgeInsetsGeometry.symmetric(
                        // vertical: 8.0,
                        horizontal: 8.0,
                      ),
                      width: double.infinity,
                      color: CupertinoColors.secondarySystemFill.resolveFrom(
                        context,
                      ),
                      child: Row(
                        children: [
                          Text('Posts'),

                          Spacer(),
                          CupertinoButton(
                            padding: EdgeInsetsGeometry.symmetric(
                              horizontal: 16.0,
                            ),
                            // sizeStyle: CupertinoButtonSize.medium,
                            // color: CupertinoColors.secondaryLabel.resolveFrom(
                            //   context,
                            // ),
                            child: Icon(
                              CupertinoIcons.search,
                              color: CupertinoColors.secondaryLabel.resolveFrom(
                                context,
                              ),
                            ),
                            onPressed: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pushNamedAndRemoveUntil(
                                  '/search-posts-page',
                                  (route) => true,
                                  arguments: communityData.communityId,
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    height: 40,
                  ),
                ),

                SliverSafeArea(
                  sliver: SliverFillRemaining(
                    hasScrollBody: true,
                    child: CupertinoScrollbar(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 8,
                            children: [
                              Icon(CupertinoIcons.pencil_outline, size: 100),
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
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is GetCommunityError) {
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
                      context.read<GetCommunityBloc>().add(
                        RetryCommunityResultLoad(widget.communityId),
                      );
                    },
                  ),
                  Spacer(),
                ],
              ),
            );
          }

          return Center();
        },
      ),
    );
  }
}
