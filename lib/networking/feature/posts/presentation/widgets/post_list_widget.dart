import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/networking/feature/posts/presentation/cubit/post_cubit.dart';

class PostListWidget extends StatelessWidget {
  const PostListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostLoaded) {
          final posts = state.posts;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(post.title),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/postDetail',
                    arguments: post.id,
                  );
                },
              );
            },
          );
        } else if (state is PostError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }
}
