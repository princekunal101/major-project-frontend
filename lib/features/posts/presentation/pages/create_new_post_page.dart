import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/features/posts/presentation/widget/add_post_flair_widget_popup.dart';
import 'package:college_project/features/posts/presentation/widget/community_rules_widget_popup.dart';
import 'package:college_project/features/posts/presentation/widget/select_community_list_widget.dart';
import 'package:flutter/cupertino.dart';

class CreateNewPostPage extends StatefulWidget {
  const CreateNewPostPage({super.key});

  @override
  State<CreateNewPostPage> createState() => _CreateNwePostPageState();
}

class _CreateNwePostPageState extends State<CreateNewPostPage> {
  final SecureStorageService storageService = SecureStorageService();

  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _subTitleTextController = TextEditingController();
  final TextEditingController _bodyTextController = TextEditingController();
  final TextEditingController _summaryTitleTextController =
      TextEditingController();
  final TextEditingController _summaryBodyTextController =
      TextEditingController();

  int _summaryBodyTextCount = 0;
  int _bodyTextCount = 0;

  void clearStorage() async {
    await storageService.clearAll();
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
                    'Select a Community',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(CupertinoIcons.arrow_up_arrow_down_circle),
                ],
              ),
            ),
            onPressed: () async {
              final result = await showCupertinoModalPopup(
                context: context,
                builder: (context) => SelectCommunityListWidget(),
              );
            },
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          onPressed: null,
          child: Text('Post', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),

      child: SafeArea(
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
                            builder: (context) => CommunityRulesWidgetPopup(),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          color: CupertinoColors.separator.resolveFrom(context),
                        ),

                        CupertinoTextField.borderless(
                          padding: EdgeInsetsGeometry.symmetric(
                            horizontal: 16.0,
                          ),
                          placeholderStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.tertiaryLabel.resolveFrom(
                              context,
                            ),
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
      ),
    );
  }
}
