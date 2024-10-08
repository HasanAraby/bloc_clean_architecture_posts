import 'package:bloc_clean_architecture_posts/core/constants/strings.dart';
import 'package:bloc_clean_architecture_posts/core/dependency_injection/dependency_injection.dart';
import 'package:bloc_clean_architecture_posts/core/errors/failure.dart';
import 'package:bloc_clean_architecture_posts/core/network/network_info.dart';
import 'package:bloc_clean_architecture_posts/features/posts/data/data_sources/local_data_source.dart';
import 'package:bloc_clean_architecture_posts/features/posts/data/data_sources/remote_data_source.dart';
import 'package:bloc_clean_architecture_posts/features/posts/data/models/post_model.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostsRepositoryImp implements PostsRepository {
  final NetworkInfo networkInfo;
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  PostsRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  bool? x;
  @override
  Future<Either<Failure, List<PostModel>>> getPosts(int st) async {
    if (await networkInfo.isConnected) {
      try {
        final list = await remoteDataSource.getPosts(st);
        localDataSource.cachePosts(list);
        x = false;
        return Right(list);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errMessage));
      }
    } else {
      try {
        final list = await localDataSource.getCachedPosts();
        if (x == null) {
          x = false;
          return Right(list);
        }

        return Left(Failure(errMessage: Strings.serverExcMessage));
      } on CacheException catch (e) {
        return Left(Failure(errMessage: e.errMessage));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity post) async {
    final PostModel postModel =
        PostModel(userId: 1, title: post.title, body: post.body);
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
        PostModel(userId: 1, id: post.id, title: post.title, body: post.body);
    try {
      await remoteDataSource.updatePost(postModel);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(Failure(errMessage: e.errMessage));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getCachedPosts() async {
    try {
      final list = await localDataSource.getCachedPosts();
      return Right(list);
    } on CacheException catch (e) {
      return Left(Failure(errMessage: e.errMessage));
    }
  }
}
