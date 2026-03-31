import 'package:college_project/core/utils/enums/community_shared_value.dart';
import 'package:college_project/core/utils/enums/community_topic.dart';
import 'package:college_project/core/utils/enums/community_type.dart';

abstract class CreateCommunityEvent {}

class CreateCommunitySubmitted extends CreateCommunityEvent {
  final String topic;
  final String sharedValue;
  final String communityType;
  final String communityName;
  final String description;
  final String displayName;

  CreateCommunitySubmitted({
    required this.topic,
    required this.sharedValue,
    required this.communityType,
    required this.communityName,
    required this.description,
    required this.displayName,
  });
}

class CreateCommunityChanged extends CreateCommunityEvent {
  final String? value;

  CreateCommunityChanged(this.value);
}
