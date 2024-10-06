part of 'cud_post_bloc.dart';

sealed class CudPostEvent extends Equatable {
  const CudPostEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends CudPostEvent {
  final PostEntity post;

  const AddPostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends CudPostEvent {
  final PostEntity post;

  const UpdatePostEvent({required this.post});
  @override
  List<Object> get props => [];
}

class DeletePostEvent extends CudPostEvent {
  final int id;

  const DeletePostEvent({required this.id});
  @override
  List<Object> get props => [id];
}
