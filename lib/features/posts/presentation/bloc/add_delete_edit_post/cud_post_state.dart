part of 'cud_post_bloc.dart';

sealed class CudPostState extends Equatable {
  const CudPostState();

  @override
  List<Object> get props => [];
}

final class CudPostInitial extends CudPostState {}

class LoadingState extends CudPostState {}

class SuccessAddDeleteUpdateState extends CudPostState {
  final String message;

  const SuccessAddDeleteUpdateState({required this.message});
  @override
  List<Object> get props => [message];
}

class ErrorAddDeleteUpdateState extends CudPostState {
  final String message;

  const ErrorAddDeleteUpdateState({required this.message});
  @override
  List<Object> get props => [message];
}
