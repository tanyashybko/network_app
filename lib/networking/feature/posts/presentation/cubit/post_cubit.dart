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
      emit(PostLoaded(posts: posts));
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  Future<void> removePost(int postId) async {
    try {
      await deletePostUseCase.execute(postId);
      await fetchPosts();
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  Future<void> removeComment(int commentId) async {
    try {
      await deleteCommentUseCase.execute(commentId);
      await fetchPosts();
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  Future<List<CommentModel>> getComments(int postId) async {
    try {
      final comments = await getCommentsUseCase.execute(postId);
      return comments;
    } catch (e) {
      throw Exception('Failed to load comments: ${e.toString()}');
    }
  }
}
