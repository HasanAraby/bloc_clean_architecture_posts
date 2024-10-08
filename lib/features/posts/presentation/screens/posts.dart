import 'package:bloc_clean_architecture_posts/core/constants/strings.dart';
import 'package:bloc_clean_architecture_posts/core/functions/snack_bar.dart';
import 'package:bloc_clean_architecture_posts/core/routes/routing_extension.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/screens/add_post.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/widgets/List_view.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() => _onScroll());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      if (currentScroll >= maxScroll) {
        BlocProvider.of<PostsBloc>(context).add(GetPostsEvent());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POSTS'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(const AddPost());
        },
        child: const Icon(Icons.add),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return RefreshIndicator(
      onRefresh: () async {
        BlocListener<PostsBloc, PostsState>(
          listener: (context, state) {
            if (state.postStatus == PostStatus.errorApi) {
              context.snack(Strings.cacheExcMessage, true);
            }
            if (state.postStatus == PostStatus.loading) return;
            BlocProvider.of<PostsBloc>(context).add(GetPostsEvent());
          },
        );
      },
      child: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        if (state.postStatus == PostStatus.loading) {
          return const CustomLoading();
        } else if (state.postStatus == PostStatus.success) {
          int rqm = state.posts.length;
          print("========== $rqm");
          return CustomList(
            controller: _scrollController,
            list: state.posts,
            reachMax: state.hasReachedMax,
          );
        } else if (state.postStatus == PostStatus.errorLocal) {
          // ErrotGetPostsState
          return const Center(
            child: Text('No data, try to connect to internet.'),
          );
        } else if (state.postStatus == PostStatus.errorApi) {
          return CustomList(
            controller: _scrollController,
            list: state.posts,
            reachMax: state.hasReachedMax,
          );
        } else {
          return const Text('not included state');
        }
      }),
    );
  }
}
