import 'package:bloc_clean_architecture_posts/core/api/api_consumer.dart';
import 'package:bloc_clean_architecture_posts/core/constants/end_points.dart';
import 'package:bloc_clean_architecture_posts/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';

class RemoteDataSource {
  final ApiConsumer api;

  RemoteDataSource({required this.api});

  Future<List<PostModel>> getPosts() async {
    final response = await api.get('{$EndPoints.posts}');

    final ret =
        response.map<PostModel>((item) => PostModel.fromJson(item)).toList();
    return ret;
  }

  Future<Unit> addPost(PostModel post) async {
    await api.post('{$EndPoints.posts}', data: post, isFormData: true);
    return Future.value(unit);
  }

  Future<Unit> deletePost(int id) async {
    await api.delete('{$EndPoints.posts}/{$id.tostring()}');
    return Future.value(unit);
  }

  Future<Unit> updatePost(PostModel post) async {
    await api.patch('{$EndPoints.posts}/{$id.tostring()}',
        data: post, isFormData: true);
    return Future.value(unit);
  }
}
