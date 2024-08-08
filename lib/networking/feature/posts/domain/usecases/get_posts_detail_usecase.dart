import 'package:network_app/networking/feature/posts/data/models/isar/comment_model_isar.dart';
import 'package:network_app/networking/feature/posts/data/models/isar/post_model_isar.dart';
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
