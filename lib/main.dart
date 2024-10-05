import 'package:bloc_clean_architecture_posts/core/dependency_injection/dependency_injection.dart'
    as di;
import 'package:bloc_clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/screens/posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) => di.sl<PostsBloc>()..add(GetPostsEvent()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Posts(),
      ),
    );
  }
}
