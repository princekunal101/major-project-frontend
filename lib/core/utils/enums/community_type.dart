enum CommunityType {
  private, // only member can interact with community and need to take permission to enter it
  public, // all can be access and can post
  restricted, // only admin can post
}

extension CommunityTypeTitle on CommunityType {
  String get title {
    switch (this) {
      case CommunityType.private:
        return 'Private';
      case CommunityType.public:
        return 'Public';
      case CommunityType.restricted:
        return 'Restricted';
    }
  }
}
