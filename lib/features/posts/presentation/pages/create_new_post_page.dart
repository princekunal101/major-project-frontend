import 'package:college_project/core/services/dio_client.dart';
import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:college_project/features/feed/data/datasources/feed_remote_data_source.dart';
import 'package:college_project/features/feed/data/repositories/feed_repository_impl.dart';
import 'package:college_project/features/feed/domain/usecase/get_community_lists.dart';
import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_bloc.dart';
import 'package:college_project/features/posts/presentation/bloc/create_post_bloc/create_post_bloc.dart';
import 'package:college_project/features/posts/presentation/bloc/create_post_bloc/create_post_event.dart';
import 'package:college_project/features/posts/presentation/bloc/create_post_bloc/create_post_state.dart';
import 'package:college_project/features/posts/presentation/widget/add_post_flair_widget_popup.dart';
import 'package:college_project/features/posts/presentation/widget/community_rules_widget_popup.dart';
import 'package:college_project/features/posts/presentation/widget/select_community_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNewPostPage extends StatefulWidget {
  const CreateNewPostPage({super.key});

  @override
  State<CreateNewPostPage> createState() => _CreateNwePostPageState();
}

class _CreateNwePostPageState extends State<CreateNewPostPage> {
  final SecureStorageService storageService = SecureStorageService();
  late DioClient dioClient = DioClient(storageService);

  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _subTitleTextController = TextEditingController();
  final TextEditingController _bodyTextController = TextEditingController();
  final TextEditingController _summaryTitleTextController =
      TextEditingController();
  final TextEditingController _summaryBodyTextController =
      TextEditingController();

  int _summaryBodyTextCount = 0;
  int _bodyTextCount = 0;

  String communityName = '';
  String communityId = '';

  void clearStorage() async {
    await storageService.clearAll();
  }

  void onCreatePost() {
    context.read<CreatePostBloc>().add(
      CreatePostSubmitted(
        communityId: communityId,
        title: _titleTextController.text.trim(),
        subTitle: _subTitleTextController.text.isNotEmpty
            ? _subTitleTextController.text.trim()
            : null,
        body: _bodyTextController.text.trim(),
        tags: null,
        summaryTitle: _summaryTitleTextController.text.isNotEmpty
            ? _summaryTitleTextController.text.trim()
            : null,
        summary: _summaryBodyTextController.text.isNotEmpty
            ? _summaryBodyTextController.text.trim()
            : null,
        contentType: 'text',
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTextController.dispose();
    _subTitleTextController.dispose();
    _bodyTextController.dispose();
    _summaryTitleTextController.dispose();
    _summaryBodyTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsetsDirectional.all(0),
          child: Text('Close'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: CupertinoButton.tinted(
            padding: EdgeInsetsDirectional.all(0),
            sizeStyle: CupertinoButtonSize.small,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4,
                children: [
                  Text(
                    communityName.isEmpty
                        ? 'Select a Community'
                        : 'c/$communityName',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(CupertinoIcons.arrow_up_arrow_down_circle),
                ],
              ),
            ),
            onPressed: () async {
              final result = await showCupertinoModalPopup(
                context: context,
                builder: (context) => BlocProvider<SearchCommunityBloc>(
                  create: (_) => SearchCommunityBloc(
                    GetCommunityLists(
                      FeedRepositoryImpl(FeedRemoteDataSource(dioClient.dio)),
                    ),
                  ),
                  child: SelectCommunityListWidget(),
                ),
              );
              if (result != null) {
                setState(() {
                  communityName = result['communityName'];
                  communityId = result['communityId'];
                });
              }
                print(result['communityId']);

            },
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          onPressed:
              (communityId != '' &&
                  communityName != '' &&
                  _titleTextController.text.isEmpty &&
                  _bodyTextController.text.isEmpty)
              ? null
              : () {
                  onCreatePost();
                },
          child: Text('Post', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),

      child: BlocConsumer<CreatePostBloc, CreatePostState>(
        builder: (context, state) {
          if (state is CreatePostLoading) {
            return Center(child: CupertinoActivityIndicator());
          }

          if (state is CreatePostSuccess) {
            Navigator.pop(context);
          }

          return SafeArea(
            child: Center(
              child: Column(
                spacing: 8,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CupertinoTextField.borderless(
                            placeholder: 'Title',
                            minLines: 1,
                            maxLines: 4,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.next,
                            placeholderStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.tertiaryLabel.resolveFrom(
                                context,
                              ),
                            ),
                            textCapitalization: TextCapitalization.sentences,
                            controller: _titleTextController,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CupertinoButton.tinted(
                            sizeStyle: CupertinoButtonSize.small,
                            // padding: EdgeInsetsDirectional.symmetric(
                            //   horizontal: 14.0,
                            // ),
                            child: Text('Rule'),
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) =>
                                    CommunityRulesWidgetPopup(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  CupertinoTextField.borderless(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
                    // placeholderStyle: TextStyle(fontSize: 18, ),
                    placeholder: 'Subtitle (Optional)',
                    minLines: null,
                    maxLines: null,
                    expands: true,
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _subTitleTextController,
                    textCapitalization: TextCapitalization.sentences,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        CupertinoButton.tinted(
                          sizeStyle: CupertinoButtonSize.small,
                          child: Text('Add flair'),
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => AddPostFlairWidgetPopup(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: CupertinoScrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: 8,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Spacer(),
                                      Text(
                                        '$_bodyTextCount',
                                        style: TextStyle(
                                          color: CupertinoColors.secondaryLabel
                                              .resolveFrom(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                  CupertinoTextField(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    // placeholderStyle: TextStyle(fontSize: 18, ),
                                    placeholder: 'Body',
                                    minLines: 7,
                                    maxLines: null,
                                    // expands: true,
                                    style: TextStyle(fontSize: 18),
                                    keyboardType: TextInputType.multiline,
                                    controller: _bodyTextController,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    onChanged: (value) {
                                      setState(() {
                                        _bodyTextCount = value.length;
                                      });
                                    },
                                    // textInputAction: TextInputAction.done,
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              height: 0.5,
                              width: double.infinity,
                              color: CupertinoColors.separator.resolveFrom(
                                context,
                              ),
                            ),

                            CupertinoTextField.borderless(
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 16.0,
                              ),
                              placeholderStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.tertiaryLabel
                                    .resolveFrom(context),
                              ),

                              placeholder: 'Summary Title (Optional)',
                              minLines: 1,
                              maxLines: 4,
                              // expands: true,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              keyboardType: TextInputType.text,
                              controller: _summaryTitleTextController,
                              textCapitalization: TextCapitalization.sentences,

                              // textInputAction: TextInputAction.done,
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Spacer(),
                                      Text(
                                        '$_summaryBodyTextCount',
                                        style: TextStyle(
                                          color: CupertinoColors.secondaryLabel
                                              .resolveFrom(context),
                                        ),
                                      ),
                                    ],
                                  ),

                                  CupertinoTextField(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    // placeholderStyle: TextStyle(fontSize: 18, ),
                                    placeholder: 'Summary Body (Optional)',
                                    controller: _summaryBodyTextController,
                                    minLines: 5,
                                    maxLines: null,
                                    // expands: true,
                                    style: TextStyle(fontSize: 16),
                                    keyboardType: TextInputType.multiline,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    // textInputAction: TextInputAction.done,
                                    onChanged: (value) {
                                      setState(() {
                                        _summaryBodyTextCount = value.length;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            // Spacer(),
                            // Text('Create Post Screen'),
                            // Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, CreatePostState state) {
          if (state is CreatePostFailure) {
            ErrorPopup.show(
              context,
              'Something went wrong! try again later: ${state.message}',
            );
          }
        },
      ),
    );
  }
}
