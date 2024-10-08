import 'package:bloc_clean_architecture_posts/core/api/api_consumer.dart';
import 'package:bloc_clean_architecture_posts/core/constants/end_points.dart';
import 'package:bloc_clean_architecture_posts/core/errors/failure.dart';
import 'package:bloc_clean_architecture_posts/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';

class RemoteDataSource {
  final ApiConsumer api;

  RemoteDataSource({required this.api});

  Future<List<PostModel>> getPosts(int st) async {
    final response = await api.get('${EndPoints.posts}?_start=$st&_limit=10');

    final ret =
        response.map<PostModel>((item) => PostModel.fromJson(item)).toList();
    return ret;
  }

  Future<Unit> addPost(PostModel post) async {
    await api.post('${EndPoints.posts}', data: post, isFormData: false);
    return Future.value(unit);
  }

  Future<Unit> deletePost(int id) async {
    String rqm = id.toString();
    await api.delete('${EndPoints.posts}/${rqm}');
    return Future.value(unit);
  }

  Future<Unit> updatePost(PostModel post) async {
    String rqm = post.id.toString();
    await api.patch('${EndPoints.posts}/${rqm}', data: post, isFormData: false);
    return Future.value(unit);
  }
}
