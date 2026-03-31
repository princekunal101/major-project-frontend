enum CommunitySharedValue {
  knowledgeSharing,
  activism,
  entertainment,
  creativity,
  innovation,
  support,
}

extension SharedValueTitle on CommunitySharedValue {
  String get title {
    switch (this) {
      case CommunitySharedValue.knowledgeSharing:
        return 'Knowledge Sharing';
      case CommunitySharedValue.activism:
        return 'Activism';
      case CommunitySharedValue.entertainment:
        return 'Entertainment';
      case CommunitySharedValue.creativity:
        return 'Creativity';
      case CommunitySharedValue.innovation:
        return 'Innovation';
      case CommunitySharedValue.support:
        return 'Support';
    }
  }
}
