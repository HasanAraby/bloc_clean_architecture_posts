import 'package:bloc_clean_architecture_posts/core/api/dio_consumer.dart';
import 'package:bloc_clean_architecture_posts/core/errors/failure.dart';
import 'package:bloc_clean_architecture_posts/core/network/network_info.dart';
import 'package:bloc_clean_architecture_posts/features/posts/data/data_sources/local_data_source.dart';
import 'package:bloc_clean_architecture_posts/features/posts/data/data_sources/remote_data_source.dart';
import 'package:bloc_clean_architecture_posts/features/posts/data/models/post_model.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class PostsRepositoryImp implements PostsRepository {
  final DioConsumer api;
  final NetworkInfo networkInfo;
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  PostsRepositoryImp(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo,
      required this.api});
  @override
  Future<Either<Failure, List<PostModel>>> getPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final list = await remoteDataSource.getPosts();
        localDataSource.cachePosts(list);
        return Right(list);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errMessage));
      }
    } else {
      try {
        final list = await localDataSource.getCachedPosts();
        return Right(list);
      } on CacheException catch (e) {
        return Left(Failure(errMessage: e.errMessage));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity post) async {
    final PostModel postModel =
        PostModel(userId: "1", id: post.id, title: post.title, body: post.body);
    try {
      await remoteDataSource.addPost(postModel);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(Failure(errMessage: e.errMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    try {
      await remoteDataSource.deletePost(id);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(Failure(errMessage: e.errMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post) async {
    final PostModel postModel =
        PostModel(userId: "1", id: post.id, title: post.title, body: post.body);
    try {
      await remoteDataSource.updatePost(postModel);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(Failure(errMessage: e.errMessage));
    }
  }
}
