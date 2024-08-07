import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/networking/feature/posts/domain/usecases/delete_comment_usecase.dart';
import 'package:network_app/networking/feature/posts/domain/usecases/delete_post_usecase.dart';
import 'package:network_app/networking/feature/posts/domain/usecases/get_comments_usecase.dart';
import 'package:network_app/networking/feature/posts/domain/usecases/get_posts_usecase.dart';
import 'package:network_app/networking/feature/posts/presentation/cubit/post_cubit.dart';
import 'package:network_app/networking/feature/posts/presentation/widgets/post_list_widget.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit(
        getPostsUseCase: RepositoryProvider.of<GetPostsUseCase>(context),
        deletePostUseCase: RepositoryProvider.of<DeletePostUseCase>(context),
        deleteCommentUseCase:
            RepositoryProvider.of<DeleteCommentUseCase>(context),
        getCommentsUseCase: RepositoryProvider.of<GetCommentsUseCase>(context),
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
