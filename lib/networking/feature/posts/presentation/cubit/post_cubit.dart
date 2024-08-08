import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/networking/feature/posts/data/models/comment_model.dart';
import 'package:network_app/networking/feature/posts/data/models/post_model.dart';
import 'package:network_app/networking/feature/posts/domain/usecases/delete_comment_usecase.dart';
import 'package:network_app/networking/feature/posts/domain/usecases/delete_post_usecase.dart';
import 'package:network_app/networking/feature/posts/domain/usecases/get_comments_usecase.dart';
import 'package:network_app/networking/feature/posts/domain/usecases/get_posts_usecase.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({
    required this.getPostsUseCase,
    required this.deletePostUseCase,
    required this.deleteCommentUseCase,
    required this.getCommentsUseCase,
  }) : super(PostInitial());

  final GetPostsUseCase getPostsUseCase;
  final DeletePostUseCase deletePostUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;
  final GetCommentsUseCase getCommentsUseCase;

  Future<void> fetchPosts() async {
    try {
      emit(PostLoading());
      final posts = await getPostsUseCase.execute();
      emit(PostLoaded(
        posts: posts,
        comments: const {}, // Initialize with empty map
      ),);
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  Future<void> removePost(int postId) async {
    try {
      final currentState = state;
      if (currentState is PostLoaded) {
        emit(PostLoading());
        await deletePostUseCase.execute(postId);
        final updatedPosts =
            currentState.posts.where((post) => post.id != postId).toList();
        emit(PostLoaded(
          posts: updatedPosts,
          comments: currentState.comments,
        ),);
      }
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  Future<void> removeComment(int postId, int commentId) async {
    try {
      final currentState = state;
      if (currentState is PostLoaded) {
        await deleteCommentUseCase.execute(commentId);
        final updatedComments =
            Map<int, List<CommentModel>>.from(currentState.comments);
        updatedComments[postId] = updatedComments[postId]
                ?.where((comment) => comment.id != commentId)
                .toList() ??
            [];
        emit(PostLoaded(
          posts: currentState.posts,
          comments: updatedComments,
        ),);
      }
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  Future<void> fetchComments(int postId) async {
    try {
      final currentState = state;
      if (currentState is PostLoaded) {
        final comments = await getCommentsUseCase.execute(postId);
        final updatedComments =
            Map<int, List<CommentModel>>.from(currentState.comments);
        updatedComments[postId] = comments;
        emit(PostLoaded(
          posts: currentState.posts,
          comments: updatedComments,
        ),);
      }
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }
}
