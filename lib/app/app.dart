export 'view/app.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/networking/api/api_service.dart';
import 'package:network_app/networking/dio_service.dart';
import 'package:network_app/networking/feature/posts/data/repository/post_repository.dart';
import 'package:network_app/networking/feature/posts/presentation/widgets/post_list_widget.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DioService>(
          create: (context) => DioService(dioClient: Dio()),
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
      ],
      child: MaterialApp(
        title: 'Network App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PostListWidget(),
      ),
    );
  }
}
