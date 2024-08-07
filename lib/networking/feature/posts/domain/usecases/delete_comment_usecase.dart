import 'package:network_app/networking/feature/posts/data/repository/post_repository.dart';

class DeleteCommentUseCase {

  DeleteCommentUseCase(this.postRepository);
  final PostRepository postRepository;

  Future<void> execute(int commentId) async {
    await postRepository.deleteComment(commentId);
  }
}
