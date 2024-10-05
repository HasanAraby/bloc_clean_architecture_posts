import 'package:bloc_clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  List<PostEntity> list;
  CustomList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: list.length,
      itemBuilder: (c, idx) {
        return ListTile(
          title: Text(list[idx].title),
          subtitle: Text(list[idx].body),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 2,
          color: Colors.green,
        );
      },
    );
  }
}
