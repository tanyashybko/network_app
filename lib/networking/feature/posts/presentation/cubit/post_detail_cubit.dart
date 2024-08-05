import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:network_app/networking/feature/posts/data/models/comment_model.dart';
import 'package:network_app/networking/feature/posts/data/models/post_model.dart';
import 'package:network_app/networking/feature/posts/data/repository/post_repository.dart';

part 'post_detail_state.dart';

class PostDetailCubit extends Cubit<PostDetailState> {
  PostDetailCubit(this.repository, this.postId) : super(PostDetailInitial());

  final PostRepository repository;
  final int postId;

  Future<void> fetchPostDetail() async {
    emit(PostDetailLoading());
    try {
      final post = await repository.getPost(postId);
      final comments = await repository.getComments(postId);
      emit(PostDetailLoaded(post: post, comments: comments));
    } catch (e) {
      emit(PostDetailError(message: e.toString()));
    }
  }
}
