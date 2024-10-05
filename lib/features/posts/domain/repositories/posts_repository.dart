import 'package:bloc_clean_architecture_posts/core/errors/failure.dart';

import 'package:bloc_clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts();
  Future<Either<Failure, Unit>> addPost(PostEntity post);
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(PostEntity post);
}
