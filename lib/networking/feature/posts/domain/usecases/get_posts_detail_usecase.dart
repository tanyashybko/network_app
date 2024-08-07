import 'package:network_app/networking/feature/posts/data/models/comment_model.dart';
import 'package:network_app/networking/feature/posts/data/models/post_model.dart';
import 'package:network_app/networking/feature/posts/data/repository/post_repository.dart';

class GetPostDetailUseCase {
  GetPostDetailUseCase(this.repository);
  final PostRepository repository;

  Future<PostModel> call(int postId) async {
    return repository.getPost(postId);
  }

  Future<List<CommentModel>> getComments(int postId) async {
    return repository.getComments(postId);
  }
}
