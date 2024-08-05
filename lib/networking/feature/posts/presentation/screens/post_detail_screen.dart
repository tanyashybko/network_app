import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/networking/feature/posts/data/repository/post_repository.dart';
import 'package:network_app/networking/feature/posts/presentation/cubit/post_detail_cubit.dart';


class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({required this.postId, super.key});
  final int postId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostDetailCubit(
        RepositoryProvider.of<PostRepository>(context),
        postId,
      )..fetchPostDetail(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Post Details'),
        ),
        body: BlocBuilder<PostDetailCubit, PostDetailState>(
          builder: (context, state) {
            if (state is PostDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostDetailLoaded) {
              final post = state.post;
              final comments = state.comments;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(post.body),
                    const SizedBox(height: 24),
                    Text(
                      'Comments:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    ...comments.map((comment) => ListTile(
                      title: Text(comment.name),
                      subtitle: Text(comment.body),
                    ),),
                  ],
                ),
              );
            } else if (state is PostDetailError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
