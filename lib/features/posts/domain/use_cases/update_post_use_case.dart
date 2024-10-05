import 'package:bloc_clean_architecture_posts/core/errors/failure.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/entities/post_entity.dart';

import 'package:bloc_clean_architecture_posts/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePostUseCase {
  final PostsRepository repository;

  UpdatePostUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(PostEntity post) async {
    return await repository.updatePost(post);
  }
}
