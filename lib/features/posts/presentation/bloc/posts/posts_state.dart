part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class LoadingState extends PostsState {}

class LoadedPostsState extends PostsState {
  final List<PostEntity> posts;

  const LoadedPostsState({required this.posts});
  @override
  List<Object> get props => [posts];
}

class LoadedCachedPostsState extends PostsState {
  final List<PostEntity> posts;

  const LoadedCachedPostsState({required this.posts});
  @override
  List<Object> get props => [posts];
}

class ErrotGetPostsState extends PostsState {}

class ErrotGetCachedPostsState extends PostsState {}

class SuccessAddDeleteUpdateState extends PostsState {
  final String message;

  const SuccessAddDeleteUpdateState({required this.message});
  @override
  List<Object> get props => [message];
}

class ErrorAddDeleteUpdateState extends PostsState {
  final String message;

  const ErrorAddDeleteUpdateState({required this.message});
  @override
  List<Object> get props => [message];
}
