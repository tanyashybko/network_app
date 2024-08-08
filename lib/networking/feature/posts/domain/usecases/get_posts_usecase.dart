// ignore_for_file: unnecessary_await_in_return

import 'package:network_app/networking/feature/posts/data/models/isar/post_model_isar.dart';
import 'package:network_app/networking/feature/posts/data/repository/post_repository.dart';

class GetPostsUseCase {

  GetPostsUseCase(this.postRepository);
  final PostRepository postRepository;

  Future<List<PostModel>> execute() async {
    return await postRepository.getPosts();
  }
}
