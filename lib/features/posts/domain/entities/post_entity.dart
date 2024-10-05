import 'package:bloc_clean_architecture_posts/core/constants/api_keys.dart';

class PostEntity {
  final int? id;
  final String title;
  final String body;

  PostEntity({this.id, required this.title, required this.body});

  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
        id: json[ApiKeys.postId],
        title: json[ApiKeys.title],
        body: json[ApiKeys.body]);
  }

  Map<String, dynamic> toJson() {
    return {ApiKeys.postId: id, ApiKeys.body: body, ApiKeys.title: title};
  }
}
