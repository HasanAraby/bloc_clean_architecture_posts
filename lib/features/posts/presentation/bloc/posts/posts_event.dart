part of 'posts_bloc.dart';

sealed class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class GetPostsEvent extends PostsEvent {
  @override
  List<Object> get props => [];
}

class GetCachedPostsEvent extends PostsEvent {
  @override
  List<Object> get props => [];
}
