// ignore_for_file: unnecessary_await_in_return

import 'package:network_app/networking/feature/posts/data/models/post_model.dart';
import 'package:network_app/networking/feature/posts/data/repository/post_repository.dart';

class GetPostsUseCase {

  GetPostsUseCase(this.repository);
  final PostRepository repository;

  Future<List<PostModel>> call() async {
    return await repository.getPosts();
  }
}