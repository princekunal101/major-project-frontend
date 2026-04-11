import 'package:flutter/cupertino.dart';

class CommentsListPopupWidget extends StatefulWidget {
  final String postId;
  final int commentCounts;

  const CommentsListPopupWidget({
    super.key,
    required this.postId,
    required this.commentCounts,
  });

  @override
  State<CommentsListPopupWidget> createState() =>
      _CommentsListPopupWidgetState();
}

class _CommentsListPopupWidgetState extends State<CommentsListPopupWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  bool _isButtonActive = false;

  void _submitText() {
    // some actions

    // clear the text
    _textEditingController.clear();
    setState(() {
      _isButtonActive = false;
    });
  }

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
                color: CupertinoColors.systemGroupedBackground.resolveFrom(
                  context,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),

              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        height: 5,
                        width: 40,
                        decoration: BoxDecoration(
                          color: CupertinoColors.separator.resolveFrom(context),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'All Comments',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 0.5,
                    width: double.infinity,
                    color: CupertinoColors.separator.resolveFrom(context),
                  ),
                  Expanded(
                    child: widget.commentCounts > 0
                        ? ListView.builder(
                            controller: scrollController,
                            itemCount: 30,

                            itemBuilder: (context, index) {
                              return CupertinoListTile.notched(
                                title: Text('u/username $index'),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.systemGrey2,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Column(
                              children: [
                                Spacer(),
                                Icon(
                                  CupertinoIcons.chat_bubble_text_fill,
                                  size: 100,
                                  color: CupertinoColors.tertiaryLabel
                                      .resolveFrom(context),
                                ),
                                Text(
                                  'No Comments Yet!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.secondaryLabel
                                        .resolveFrom(context),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                  ),

                  Container(
                    height: 0.5,
                    width: double.infinity,
                    color: CupertinoColors.separator.resolveFrom(context),
                  ),

                  SingleChildScrollView(
                    controller: scrollController,
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        spacing: 8,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: CupertinoColors.secondaryLabel.resolveFrom(
                                context,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                          ),
                          Expanded(
                            child: CupertinoTextField(
                              padding: EdgeInsets.only(
                                // right: 4,
                                left: 16,
                                top: 8,
                                bottom: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: CupertinoColors.separator.resolveFrom(context), width: 0.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                color: CupertinoColors.systemBackground
                                    .resolveFrom(context),
                              ),
                              placeholder: 'Write your comment...',
                              controller: _textEditingController,
                              // onSubmitted: (_) {
                              //   _submitText();
                              // },
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                setState(() {
                                  _isButtonActive = value.trim().isNotEmpty
                                      ? true
                                      : false;
                                });
                              },
                              suffix: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CupertinoButton.filled(
                                  padding: EdgeInsets.all(0),
                                  sizeStyle: CupertinoButtonSize.medium,
                                  onPressed: _isButtonActive
                                      ? () {
                                          _submitText();
                                        }
                                      : null,
                                  child: Icon(CupertinoIcons.up_arrow),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
