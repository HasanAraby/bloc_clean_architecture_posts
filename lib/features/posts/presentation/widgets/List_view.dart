import 'package:bloc_clean_architecture_posts/core/routes/routing_extension.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/screens/update_delete_post.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/widgets/custom_loading.dart';
import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  final List<PostEntity> list;
  final ScrollController controller;
  final bool reachMax;
  const CustomList(
      {super.key,
      required this.list,
      required this.controller,
      required this.reachMax});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      itemCount: reachMax ? 0 : 1 + list.length,
      itemBuilder: (c, idx) {
        return InkWell(
          onTap: () {
            context.push(UpdateDeletePost(
              post: list[idx],
            ));
          },
          child: idx >= list.length
              ? const CustomLoading()
              : ListTile(
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
