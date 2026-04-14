abstract class CreatePostEvent {}

class CreatePostSubmitted extends CreatePostEvent {
  final String communityId;
  final String title;
  final String body;
  final String? tags;
  final String? subTitle;
  final String? summaryTitle;
  final String? summary;
  final String contentType;
  final String? imageUrl;

  CreatePostSubmitted({
    required this.communityId,
    required this.title,
    required this.body,
    this.tags,
    this.subTitle,
    this.summaryTitle,
    this.summary,
    required this.contentType,
    this.imageUrl,
  });
}
