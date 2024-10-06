import 'package:bloc_clean_architecture_posts/core/constants/strings.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/use_cases/add_post_use_case.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/use_cases/delete_post_use_case.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/use_cases/update_post_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'cud_post_event.dart';
part 'cud_post_state.dart';

class CudPostBloc extends Bloc<CudPostEvent, CudPostState> {
  final AddPostUseCase addPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;
  CudPostBloc(
      {required this.addPostUseCase,
      required this.updatePostUseCase,
      required this.deletePostUseCase})
      : super(CudPostInitial()) {
    on<CudPostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingState());

        final failOrDone = await addPostUseCase(event.post);
        failOrDone.fold(
          (failure) {
            emit(ErrorAddDeleteUpdateState(
                message: Strings.errorPostAddMessage));
          },
          (unit) {
            emit(
                SuccessAddDeleteUpdateState(message: Strings.postAddedMessage));
          },
        );
      } else if (event is UpdatePostEvent) {
        emit(LoadingState());
        final failOrDone = await updatePostUseCase(event.post);
        failOrDone.fold(
          (failure) {
            emit(ErrorAddDeleteUpdateState(
                message: Strings.errorPostUpdateMessage));
          },
          (unit) {
            emit(SuccessAddDeleteUpdateState(
                message: Strings.postUpdatedMessage));
          },
        );
      } else if (event is DeletePostEvent) {
        emit(LoadingState());
        final failOrDone = await deletePostUseCase(event.id);
        failOrDone.fold(
          (failure) {
            emit(ErrorAddDeleteUpdateState(
                message: Strings.errorPostDeleteMessage));
          },
          (unit) {
            emit(SuccessAddDeleteUpdateState(
                message: Strings.postDeletedMessage));
          },
        );
      }
    });
  }
}
