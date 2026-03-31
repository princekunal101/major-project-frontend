import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_bloc.dart';
import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_event.dart';
import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_state.dart';
import 'package:college_project/features/feed/presentation/widgets/community_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidgetPage extends StatelessWidget {
  const SearchWidgetPage({super.key});

  // final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoSearchTextField(
          autofocus: true,

          // controller: _searchController,
          onChanged: (query) {
            // onSubmitSearch();
            context.read<SearchCommunityBloc>().add(
              SearchCommunityStringSubmitted(communityName: query.trim()),
            );
          },

          // onSubmitted: (query) {
          //   context.read<SearchCommunityBloc>().add(
          //     SearchCommunityStringSubmitted(communityName: query.trim()),
          //   );
          // },
        ),
        // transitionBetweenRoutes: false,
        automaticallyImplyLeading: false,
        trailing: CupertinoButton(
          padding: EdgeInsetsGeometry.all(0.0),
          child: Text('cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: SafeArea(
        child: BlocBuilder<SearchCommunityBloc, SearchCommunityState>(
          builder: (context, state) {
            if (state is SearchCommunityLoading) {}
        
            if (state is SearchCommunityFailure) {
              return  Center(child: Text(state.message));
        
            }
        
            if (state is SearchCommunityLoaded) {
              final searchList = state.responseModel;
              return (searchList.listItem.isNotEmpty)
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
                    : Center(child: Text('No Data Found!'));
        
            }
            return Center(child: Text('No DataFound!'));
        
          },
        ),
      ),
    );
  }
}
