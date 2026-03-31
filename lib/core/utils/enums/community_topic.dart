enum CommunityTopic {
  topic, // e.g. "Photography", "Fitness"
  brand, // e.g. "Nike", "Apple"
  creator, // e.g. "YouTuber", "Writer"
  movement, // e.g. "Open Source", "Minimalism"
  cause, // e.g. "Climate Actions", "Animal Rights"
  identity, // e.g. "Students", "Teachers", "Gamers"
}

extension CommunityTopicTitle on CommunityTopic {
  String get title {
    switch (this) {
      case CommunityTopic.topic:
        return 'Topics';
      case CommunityTopic.brand:
        return 'Brand';
      case CommunityTopic.creator:
        return 'Creator';
      case CommunityTopic.movement:
        return 'Movement';
      case CommunityTopic.cause:
        return 'Cause';
      case CommunityTopic.identity:
        return 'Identity';
    }
  }
}
