import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/networking/feature/posts/domain/usecases/get_posts_usecase.dart';
import 'package:network_app/networking/feature/posts/presentation/cubit/post_cubit.dart';
import 'package:network_app/networking/feature/posts/presentation/widgets/post_list_widget.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit(
        RepositoryProvider.of<GetPostsUseCase>(context),
      )..fetchPosts(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
        ),
        body: const PostListWidget(),
      ),
    );
  }
}
