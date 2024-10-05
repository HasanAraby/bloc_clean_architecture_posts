import 'package:bloc_clean_architecture_posts/features/posts/domain/use_cases/delete_post_use_case.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/use_cases/add_post_use_case.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/use_cases/get_posts_use_case.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/use_cases/update_post_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsUseCase getPostsUseCase;
  final AddPostUseCase addPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;
  PostsBloc(
      {required this.getPostsUseCase,
      required this.addPostUseCase,
      required this.updatePostUseCase,
      required this.deletePostUseCase})
      : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetPostsEvent) {
        emit(LoadingState());
        final failOrPosts = await getPostsUseCase();
        failOrPosts.fold(
          (failure) {
            emit(ErrotGetPostsState());
          },
          (posts) {
            emit(LoadedPostsState(posts: posts));
          },
        );
      } else if (event is AddPostEvent) {
        emit(LoadingState());

        final failOrDone = await addPostUseCase(event.post);
        failOrDone.fold(
          (failure) {
            emit(
                const ErrorAddDeleteUpdateState(message: 'failed to add Post'));
          },
          (unit) {
            emit(const SuccessAddDeleteUpdateState(
                message: 'added successfully!'));
          },
        );
      } else if (event is UpdatePostEvent) {
        emit(LoadingState());
        final failOrDone = await updatePostUseCase(event.post);
        failOrDone.fold(
          (failure) {
            emit(const ErrorAddDeleteUpdateState(
                message: 'failed to update Post'));
          },
          (unit) {
            emit(const SuccessAddDeleteUpdateState(
                message: 'updated successfully!'));
          },
        );
      } else if (event is DeletePostEvent) {
        emit(LoadingState());
        final failOrDone = await deletePostUseCase(event.id);
        failOrDone.fold(
          (failure) {
            emit(const ErrorAddDeleteUpdateState(
                message: 'failed to delete Post'));
          },
          (unit) {
            emit(const SuccessAddDeleteUpdateState(
                message: 'deleted successfully!'));
          },
        );
      }
    });
  }
}
