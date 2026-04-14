import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_bloc.dart';
import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_event.dart';
import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_state.dart';
import 'package:college_project/features/posts/presentation/widget/community_list_post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCommunityListWidget extends StatefulWidget {
  const SelectCommunityListWidget({super.key});

  @override
  State<SelectCommunityListWidget> createState() =>
      _SelectCommunityListWidgetState();
}

class _SelectCommunityListWidgetState extends State<SelectCommunityListWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onInitiateSearch();
  }

  void onInitiateSearch() {
    context.read<SearchCommunityBloc>().add(
      SearchCommunityStringSubmitted(communityName: 'a'),
    );
  }

  void onSubmitSearch() {
    context.read<SearchCommunityBloc>().add(
      SearchCommunityStringSubmitted(communityName: controller.text.trim()),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Edit Post',
        middle: Text('Select a Community'),
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {},
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: CupertinoSearchTextField(
                controller: controller,
                onChanged: (_) {
                  onSubmitSearch();
                },
              ),
            ),
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
                                  (item) => CommunityListPostWidget(
                                    communityId: item.communityId,
                                    displayName: item.displayName,
                                    displayPicUrl: item.displayUrl,
                                    communityName: item.communityName,
                                    totalMember: item.totalMember,
                                    totalPosts: item.totalPosts,

                                    onTap: () {
                                      Navigator.pop(context, {
                                        "communityId": item.communityId,
                                        "communityName": item.communityName,
                                      });
                                    },
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
            // Expanded(child: Center(child: Text('Community List!'))),
          ],
        ),
      ),
    );
  }
}
