import 'package:bloc_clean_architecture_posts/core/functions/snack_bar.dart';
import 'package:bloc_clean_architecture_posts/core/functions/valid_input.dart';
import 'package:bloc_clean_architecture_posts/core/routes/routing_extension.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/widgets/custom_button.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/widgets/custom_loading.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/widgets/post_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateDeletePost extends StatefulWidget {
  final PostEntity post;
  const UpdateDeletePost({super.key, required this.post});

  @override
  State<UpdateDeletePost> createState() => _AddPostState();
}

class _AddPostState extends State<UpdateDeletePost> {
  TextEditingController title = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController body = TextEditingController();
  @override
  void initState() {
    title.text = widget.post.title;
    body.text = widget.post.body;
    super.initState();
  }

  @override
  void dispose() {
    title.dispose();
    body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT'),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return BlocConsumer<PostsBloc, PostsState>(
      listener: (context, state) {
        if (state is SuccessAddDeleteUpdateState) {
          BlocProvider.of<PostsBloc>(context).add(GetPostsEvent());
          context.pop();
          context.snack(state.message, false);
        } else if (state is ErrorAddDeleteUpdateState) {
          context.snack(state.message, true);
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const CustomLoading();
        } else {
          return Center(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 150,
                  right: 25,
                  left: 25,
                  bottom: 30,
                ),
                child: ListView(
                  children: [
                    PostFormField(
                      hintTxt: 'title',
                      valid: (v) {
                        return validInput(v);
                      },
                      controller: title,
                      lines: 1,
                    ),
                    const SizedBox(height: 15),
                    PostFormField(
                      hintTxt: 'body',
                      valid: (v) {
                        return validInput(v);
                      },
                      controller: body,
                      lines: 8,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<PostsBloc>(context).add(
                                UpdatePostEvent(
                                    post: PostEntity(
                                        id: widget.post.id,
                                        body: body.text,
                                        title: title.text)));
                          }
                        },
                        txt: 'Edit'),
                    const SizedBox(height: 20),
                    CustomButton(
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<PostsBloc>(context)
                                .add(DeletePostEvent(id: widget.post.id!));
                          }
                        },
                        color: Colors.red,
                        txt: 'Delete'),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
