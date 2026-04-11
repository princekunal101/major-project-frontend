//
// import 'package:college_project/features/posts/presentation/widget/posts_list_item_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class SearchPostsPage extends StatelessWidget {
//   final String communityId;
//
//   const SearchPostsPage({super.key, required this.communityId});
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: CupertinoSearchTextField(
//           autofocus: true,
//
//           // controller: _searchController,
//           onChanged: (query) {
//             // onSubmitSearch();
//             context.read<SearchPostsBloc>().add(
//               SearchPostsSubmitted(
//                 communityId: communityId,
//                 title: query.trim(),
//                 cursor: '',
//               ),
//             );
//           },
//
//           // onSubmitted: (query) {
//           //   context.read<SearchCommunityBloc>().add(
//           //     SearchCommunityStringSubmitted(communityName: query.trim()),
//           //   );
//           // },
//         ),
//         // transitionBetweenRoutes: false,
//         automaticallyImplyLeading: false,
//         trailing: CupertinoButton(
//           padding: EdgeInsetsGeometry.all(0.0),
//           child: Text('cancel'),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       child: SafeArea(
//         child: BlocBuilder<SearchPostsBloc, SearchPostsState>(
//           builder: (context, state) {
//             if (state is SearchPostsLoading) {}
//
//             if (state is SearchPostsFailure) {
//               return Center(child: Text(state.message));
//             }
//
//             if (state is SearchPostsLoaded) {
//               final searchList = state.responseModel;
//               return (searchList.list.isNotEmpty)
//                   ? CupertinoListSection(
//                       header: Text('Posts'),
//                       children: searchList.list
//                           .map(
//                             (item) => PostsListItemWidget(
//                               postId: item.id,
//                               title: item.title,
//                               subTitle: item.subTitle,
//                               body: item.body,
//                               likesCount: item.likesCount,
//                               commentCount: item.commentCount,
//                               createdAt: item.,
//                               postedBy: item.userId,
//                             ),
//                           )
//                           .toList(),
//                     )
//                   : Center(child: Text('No Data Found!'));
//             }
//             return Center(child: Text('No DataFound!'));
//           },
//         ),
//       ),
//     );
//   }
// }
