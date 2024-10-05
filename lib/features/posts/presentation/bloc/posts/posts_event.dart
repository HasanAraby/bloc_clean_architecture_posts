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

class AddPostEvent extends PostsEvent {
  final PostEntity post;

  const AddPostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends PostsEvent {
  final PostEntity post;

  const UpdatePostEvent({required this.post});
  @override
  List<Object> get props => [];
}

class DeletePostEvent extends PostsEvent {
  final int id;

  const DeletePostEvent({required this.id});
  @override
  List<Object> get props => [id];
}
