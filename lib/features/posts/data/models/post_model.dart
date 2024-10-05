import 'package:bloc_clean_architecture_posts/core/constants/api_keys.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  final String userId;

  PostModel(
      {required this.userId,
      required super.id,
      required super.title,
      required super.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        userId: json[ApiKeys.userId],
        id: json[ApiKeys.postId],
        title: json[ApiKeys.title],
        body: json[ApiKeys.body]);
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.userId: userId,
      ApiKeys.postId: id,
      ApiKeys.body: body,
      ApiKeys.title: title
    };
  }
}
