import 'package:bloc_clean_architecture_posts/core/routes/routing_extension.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/screens/update_delete_post.dart';
import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  List<PostEntity> list;
  CustomList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: list.length,
      itemBuilder: (c, idx) {
        return InkWell(
          onTap: () {
            context.push(UpdateDeletePost(
              post: list[idx],
            ));
          },
          child: ListTile(
            leading: Text(
              list[idx].id.toString(),
              style: const TextStyle(fontSize: 18),
            ),
            title: Text(
              list[idx].title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(list[idx].body),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Divider(
            thickness: 2,
            height: 2,
            color: Colors.green,
          ),
        );
      },
    );
  }
}
