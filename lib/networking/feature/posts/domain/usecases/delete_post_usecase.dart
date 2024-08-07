import 'package:network_app/networking/feature/posts/data/repository/post_repository.dart';

class DeletePostUseCase {

  DeletePostUseCase(this.postRepository);
  final PostRepository postRepository;

  Future<void> execute(int postId) async {
    await postRepository.deletePost(postId);
  }
}
