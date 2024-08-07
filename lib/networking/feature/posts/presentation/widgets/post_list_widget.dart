import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/networking/feature/posts/presentation/cubit/post_cubit.dart';
import 'package:network_app/networking/feature/posts/presentation/screens/post_detail_screen.dart';

class PostListWidget extends StatefulWidget {
  const PostListWidget({super.key});

  @override
  _PostListWidgetState createState() => _PostListWidgetState();
}

class _PostListWidgetState extends State<PostListWidget> {
  @override
  void initState() {
    super.initState();
    context.read<PostCubit>().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<PostDetailScreen>(
                        builder: (context) => PostDetailScreen(postId: post.id),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<PostCubit>().removePost(post.id);
                    },
                  ),
                );
              },
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
