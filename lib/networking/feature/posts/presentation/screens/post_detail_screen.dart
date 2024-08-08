import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/networking/feature/posts/presentation/cubit/post_cubit.dart';

class PostDetailScreen extends StatelessWidget {

  const PostDetailScreen({required this.postId, super.key});
  final int postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Details')),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            final post = state.posts.firstWhere((post) => post.id == postId);
            final comments = state.comments[postId] ?? [];
            return Column(
              children: [
                ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<PostCubit>().fetchComments(postId);
                  },
                  child: const Text('Load Comments'),
                ),
                Expanded(
                  child: comments.isEmpty
                      ? const Center(child: Text('No comments'))
                      : ListView.builder(
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index];
                            return ListTile(
                              title: Text(comment.name),
                              subtitle: Text(comment.body),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  context
                                      .read<PostCubit>()
                                      .removeComment(postId, comment.id);
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          } else if (state is PostError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
