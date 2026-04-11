import 'package:flutter/cupertino.dart';

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
                color: CupertinoColors.systemBackground.resolveFrom(
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
                        'All Likes ($likeCounts)',
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
                    child: likeCounts > 0
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
