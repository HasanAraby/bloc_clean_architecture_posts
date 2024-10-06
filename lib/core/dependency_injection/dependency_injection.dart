import 'package:bloc_clean_architecture_posts/core/api/api_consumer.dart';
import 'package:bloc_clean_architecture_posts/core/api/api_interceptor.dart';
import 'package:bloc_clean_architecture_posts/core/api/dio_consumer.dart';
import 'package:bloc_clean_architecture_posts/core/constants/api_keys.dart';
import 'package:bloc_clean_architecture_posts/core/constants/end_points.dart';
import 'package:bloc_clean_architecture_posts/core/constants/strings.dart';
import 'package:bloc_clean_architecture_posts/core/network/network_info.dart';
import 'package:bloc_clean_architecture_posts/features/posts/data/data_sources/local_data_source.dart';
import 'package:bloc_clean_architecture_posts/features/posts/data/data_sources/remote_data_source.dart';
import 'package:bloc_clean_architecture_posts/features/posts/data/repositories/posts_repository_imp.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/repositories/posts_repository.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/use_cases/add_post_use_case.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/use_cases/delete_post_use_case.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/use_cases/get_cached_post_use_case.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/use_cases/get_posts_use_case.dart';
import 'package:bloc_clean_architecture_posts/features/posts/domain/use_cases/update_post_use_case.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/bloc/add_delete_edit_post/cud_post_bloc.dart';
import 'package:bloc_clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
// features => posts

// bloc
  sl.registerFactory(
    () => PostsBloc(getPostsUseCase: sl(), getCachedPostUseCase: sl()),
  );
  sl.registerFactory(() => CudPostBloc(
        addPostUseCase: sl(),
        deletePostUseCase: sl(),
        updatePostUseCase: sl(),
      ));

// usecases
  sl.registerLazySingleton(() => GetPostsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddPostUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCachedPostUseCase(repository: sl()));

// repositoties
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImp(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

// datasource
  sl.registerLazySingleton(() => RemoteDataSource(api: sl()));
  sl.registerLazySingleton(() => LocalDataSource(sharedPrefs: sl()));

//core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(internetChecker: sl()));
//extra
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefs);

  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));
  // sl.registerLazySingleton(() => ApiInterceptor());
  sl.registerLazySingleton(() => ApiKeys());
  sl.registerLazySingleton(() => EndPoints());
  sl.registerLazySingleton(() => Strings());
}
