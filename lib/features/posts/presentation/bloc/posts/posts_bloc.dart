import 'package:bloc_clean_architecture_posts/core/constants/strings.dart';
import 'package:bloc_clean_architecture_posts/core/functions/snack_bar.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/use_cases/get_cached_post_use_case.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/use_cases/get_posts_use_case.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:equatable/equatable.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsUseCase getPostsUseCase;

  final GetCachedPostUseCase getCachedPostUseCase;
  PostsBloc({
    required this.getCachedPostUseCase,
    required this.getPostsUseCase,
  }) : super(const PostsState()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetPostsEvent) {
        if (state.hasReachedMax) {
          // emit(state.copyWith(HasReachedMax: true));
          return;
        }
        if (state.posts.isEmpty) {
          emit(state.copyWith(
              postStatus: PostStatus.success, HasReachedMax: true));
        }
        // if it is the first time show loading
        if (state.posts.isEmpty) {
          emit(state.copyWith(postStatus: PostStatus.loading));
        }
        final failOrPosts = await getPostsUseCase(state.posts.length);
        failOrPosts.fold(
          (failure) {
            emit(state.copyWith(
                postStatus: failure.errMessage == Strings.serverExcMessage
                    ? PostStatus.errorApi
                    : PostStatus.errorLocal));
          },
          (posts) {
            emit(state.copyWith(
              postStatus: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              HasReachedMax: posts.isEmpty,
            ));
          },
        );
      }
      //else if (event is GetCachedPostsEvent) {
      //   emit(state.copyWith(postStatus: PostStatus.loading));
      //   final failOrDone = await getCachedPostUseCase();
      //   failOrDone.fold(
      //     (failure) {
      //       emit(state.copyWith(postStatus: PostStatus.errorLocal));
      //     },
      //     (posts) {
      //       emit(state.copyWith(
      //         postStatus: PostStatus.success,
      //         posts: posts,
      //         HasReachedMax: posts.isEmpty,
      //       ));
      //     },
      //   );
      // }
    }, transformer: droppable());
  }
}
