import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/networking/const.dart';
import 'package:network_app/networking/dio_service.dart';
import 'package:network_app/networking/feature/posts/data/repository/post_repository.dart';
import 'package:network_app/networking/feature/posts/domain/usecases/delete_comment_usecase.dart';
import 'package:network_app/networking/feature/posts/domain/usecases/delete_post_usecase.dart';
import 'package:network_app/networking/feature/posts/domain/usecases/get_comments_usecase.dart';
import 'package:network_app/networking/feature/posts/domain/usecases/get_posts_usecase.dart';
import 'package:network_app/networking/feature/posts/presentation/cubit/post_cubit.dart';
import 'package:network_app/networking/feature/posts/presentation/widgets/post_list_widget.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final dioClient = Dio(BaseOptions(baseUrl: baseURL));

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DioService>(
          create: (context) => DioService(dioClient: dioClient),
        ),
        RepositoryProvider<PostRepository>(
          create: (context) => PostRepository(
            apiService: RepositoryProvider.of<DioService>(context),
          ),
        ),
        RepositoryProvider<GetPostsUseCase>(
          create: (context) => GetPostsUseCase(
            RepositoryProvider.of<PostRepository>(context),
          ),
        ),
        RepositoryProvider<DeletePostUseCase>(
          create: (context) => DeletePostUseCase(
            RepositoryProvider.of<PostRepository>(context),
          ),
        ),
        RepositoryProvider<DeleteCommentUseCase>(
          create: (context) => DeleteCommentUseCase(
            RepositoryProvider.of<PostRepository>(context),
          ),
        ),
        RepositoryProvider<GetCommentsUseCase>(
          create: (context) => GetCommentsUseCase(
            RepositoryProvider.of<PostRepository>(context),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PostCubit>(
            create: (context) => PostCubit(
              getPostsUseCase: RepositoryProvider.of<GetPostsUseCase>(context),
              deletePostUseCase:
                  RepositoryProvider.of<DeletePostUseCase>(context),
              deleteCommentUseCase:
                  RepositoryProvider.of<DeleteCommentUseCase>(context),
              getCommentsUseCase:
                  RepositoryProvider.of<GetCommentsUseCase>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Network App',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            useMaterial3: true,
            primarySwatch: Colors.blue,
          ),
          home: const PostListWidget(),
        ),
      ),
    );
  }
}
