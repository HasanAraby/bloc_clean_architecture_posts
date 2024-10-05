import 'package:bloc_clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/widgets/List_view.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Posts extends StatelessWidget {
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POSTS'),
        centerTitle: true,
      ),
      body: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        if (state is LoadingState) {
          return const CustomLoading();
        } else if (state is LoadedPostsState) {
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<PostsBloc>(context).add(GetPostsEvent());
            },
            child: CustomList(list: state.posts),
          );
        } else {
          return const Center(
            child: Text('No Data'),
          );
        }
      }),
    );
  }
}
