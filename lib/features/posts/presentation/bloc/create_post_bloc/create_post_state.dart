abstract class CreatePostState {}

class CreatePostInitial extends CreatePostState {}

class CreatePostLoading extends CreatePostState {}

class CreatePostSuccess extends CreatePostState {}

class CreatePostFailure extends CreatePostState {
  final String message;

  CreatePostFailure(this.message);
}
