import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/l10n/l10n.dart';
import 'package:network_app/networking/api/api_service.dart';
import 'package:network_app/networking/const.dart';
import 'package:network_app/networking/dio_service.dart';
import 'package:network_app/networking/feature/posts/data/repository/post_repository.dart';
import 'package:network_app/networking/feature/posts/domain/usecases/get_posts_usecase.dart';
import 'package:network_app/networking/feature/posts/presentation/widgets/post_list_widget.dart';

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
        RepositoryProvider<ApiService>(
          create: (context) => ApiServiceImpl(
            RepositoryProvider.of<DioService>(context),
          ),
        ),
        RepositoryProvider<PostRepository>(
          create: (context) => PostRepository(
            apiService: RepositoryProvider.of<ApiService>(context),
          ),
        ),
        RepositoryProvider<GetPostsUseCase>(
          create: (context) => GetPostsUseCase(
            RepositoryProvider.of<PostRepository>(context),
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
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const PostListWidget(),
      ),
    );
  }
}

void main() {
  runApp(const App());
}
