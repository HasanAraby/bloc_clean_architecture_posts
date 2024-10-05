import 'package:bloc_clean_architecture_posts/core/errors/failure.dart';

import 'package:bloc_clean_architecture_posts/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  final PostsRepository repository;

  DeletePostUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deletePost(id);
  }
}
