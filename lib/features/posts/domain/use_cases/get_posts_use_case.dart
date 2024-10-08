import 'package:bloc_clean_architecture_posts/core/errors/failure.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class GetPostsUseCase {
  final PostsRepository repository;

  GetPostsUseCase({required this.repository});

  Future<Either<Failure, List<PostEntity>>> call(int st) async {
    return await repository.getPosts(st);
  }
}
