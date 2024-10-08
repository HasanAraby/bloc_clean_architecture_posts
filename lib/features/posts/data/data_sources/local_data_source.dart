import 'dart:convert';

import 'package:bloc_clean_architecture_posts/core/constants/strings.dart';
import 'package:bloc_clean_architecture_posts/core/errors/failure.dart';
import 'package:bloc_clean_architecture_posts/features/posts/data/models/post_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  final SharedPreferences sharedPrefs;

  LocalDataSource({required this.sharedPrefs});

  Future<void> cachePosts(List<PostModel> data) async {
    final list = data
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    await sharedPrefs.setString(Strings.postsLocalSource, json.encode(list));
  }

  Future<List<PostModel>> getCachedPosts() async {
    final data = sharedPrefs.getString(Strings.postsLocalSource);
    if (data != null) {
      final list = json.decode(data);
      if (list.isEmpty) {
        throw CacheException(errMessage: Strings.cacheExcMessage);
      }
      final ret =
          list.map<PostModel>((item) => PostModel.fromJson(item)).toList();
      return Future.value(ret);
    }
    throw CacheException(errMessage: Strings.cacheExcMessage);
  }
}
