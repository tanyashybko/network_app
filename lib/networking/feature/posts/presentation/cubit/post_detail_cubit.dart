import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:network_app/networking/feature/posts/data/models/isar/comment_model_isar.dart';
import 'package:network_app/networking/feature/posts/data/models/isar/post_model_isar.dart';
import 'package:network_app/networking/feature/posts/data/repository/post_repository.dart';

part 'post_detail_state.dart';

class PostDetailCubit extends Cubit<PostDetailState> {
  PostDetailCubit(this._postRepository, this._postId)
      : super(PostDetailInitial());
  final PostRepository _postRepository;
  final int _postId;

  Future<void> fetchPostDetail() async {
    try {
      emit(PostDetailLoading());
      final post = await _postRepository.getPost(_postId);
      final comments = await _postRepository.getComments(_postId);
      emit(PostDetailLoaded(post: post, comments: comments));
    } catch (e) {
      emit(PostDetailError(message: e.toString()));
    }
  }

  Future<void> deletePost() async {
    try {
      await _postRepository.deletePost(_postId);
      emit(PostDeleted());
    } catch (e) {
      emit(PostDetailError(message: e.toString()));
    }
  }

  Future<void> deleteComment(int commentId) async {
    try {
      await _postRepository.deleteComment(commentId);
      await fetchPostDetail(); // Reload the post details after deleting a comment
    } catch (e) {
      emit(PostDetailError(message: e.toString()));
    }
  }
}
