part of 'posts_bloc.dart';

enum PostStatus { loading, success, errorApi, errorLocal }

class PostsState {
  final PostStatus postStatus;
  final List<PostEntity> posts;
  final bool hasReachedMax;
  const PostsState({
    this.postStatus = PostStatus.loading,
    this.posts = const [],
    this.hasReachedMax = false,
  });

  // @override
  // List<Object> get props => [postStatus, posts, hasReachedMax];

  PostsState copyWith({
    PostStatus? postStatus,
    List<PostEntity>? posts,
    bool? HasReachedMax,
  }) {
    return PostsState(
      hasReachedMax: HasReachedMax ?? this.hasReachedMax,
      posts: posts ?? this.posts,
      postStatus: postStatus ?? this.postStatus,
    );
  }
}
