import 'package:network_app/networking/feature/posts/data/models/isar/comment_model_isar.dart';
import 'package:network_app/networking/feature/posts/data/repository/post_repository.dart';

class GetCommentsUseCase {

  GetCommentsUseCase(this.postRepository);
  final PostRepository postRepository;

  Future<List<CommentModel>> execute(int postId) async {
    return postRepository.getComments(postId);
  }
}
