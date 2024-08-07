// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:network_app/networking/feature/posts/data/repository/post_repository.dart';
// import 'package:network_app/networking/feature/posts/presentation/cubit/post_detail_cubit.dart';
//
// class PostDetailScreen extends StatelessWidget {
//   const PostDetailScreen({required this.postId, super.key});
//
//   final int postId;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => PostDetailCubit(
//         RepositoryProvider.of<PostRepository>(context),
//         postId,
//       )..fetchPostDetail(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Post Details'),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.delete),
//               onPressed: () {
//                 context.read<PostDetailCubit>().deletePost();
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//         body: BlocBuilder<PostDetailCubit, PostDetailState>(
//           builder: (context, state) {
//             if (state is PostDetailLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is PostDetailLoaded) {
//               final post = state.post;
//               final comments = state.comments;
//               return SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       post.title,
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     const SizedBox(height: 16),
//                     Text(post.body),
//                     const SizedBox(height: 24),
//                     Text(
//                       'Comments:',
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                     ...comments.map((comment) => ListTile(
//                           title: Text(comment.name),
//                           subtitle: Text(comment.body),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.delete),
//                             onPressed: () {
//                               context
//                                   .read<PostDetailCubit>()
//                                   .deleteComment(comment.id);
//                             },
//                           ),
//                         ),),
//                   ],
//                 ),
//               );
//             } else if (state is PostDetailError) {
//               return Center(child: Text(state.message));
//             } else if (state is PostDeleted) {
//               Future.microtask(() => Navigator.pop(context));
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/networking/feature/posts/data/models/comment_model.dart';
import 'package:network_app/networking/feature/posts/presentation/cubit/post_cubit.dart';

class PostDetailScreen extends StatelessWidget {

  const PostDetailScreen({required this.postId, super.key});
  final int postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: FutureBuilder<List<CommentModel>>(
        future: context.read<PostCubit>().getComments(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final comments = snapshot.data!;
            return ListView(
              children: comments.map((comment) {
                return ListTile(
                  title: Text(comment.body),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<PostCubit>().removeComment(comment.id);
                    },
                  ),
                );
              }).toList(),
            );
          }
          return const Center(child: Text('No comments found.'));
        },
      ),
    );
  }
}
