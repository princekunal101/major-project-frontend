import 'package:bloc/bloc.dart';
import 'package:college_project/features/posts/data/repositories/post_repositories_impl.dart';
import 'package:college_project/features/posts/presentation/bloc/create_post_bloc/create_post_event.dart';
import 'package:college_project/features/posts/presentation/bloc/create_post_bloc/create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final PostRepositoriesImpl repositories;

  CreatePostBloc(this.repositories) : super(CreatePostInitial()) {
    on<CreatePostSubmitted>((event, emit) async {
      emit(CreatePostLoading());

      // print('bloc post clicked');
      try {
        await repositories.createNewPost(
          event.communityId,
          event.title,
          event.subTitle,
          event.body,
          event.tags,
          event.summaryTitle,
          event.summary,
          event.contentType,
          event.imageUrl,
        );
        emit(CreatePostSuccess());
      } catch (e) {
        emit(CreatePostFailure(e.toString()));
      }
    });
  }
}
