import 'package:network_app/networking/dio_service.dart';
import 'package:network_app/networking/feature/posts/data/models/comment_model.dart';
import 'package:network_app/networking/feature/posts/data/models/post_model.dart';

class PostRepository {
  PostRepository({required this.apiService});

  final DioService apiService;

  Future<List<PostModel>> getPosts() async {
    final response = await apiService.getCollectionData<PostModel>(
      endpoint: 'posts',
      converter: PostModel.fromJson,
    );
    return response;
  }

  Future<PostModel> getPost(int postId) async {
    final response = await apiService.get<PostModel>(
      endpoint: 'posts/$postId',
      converter: PostModel.fromJson,
    );
    return response!;
  }

  Future<List<CommentModel>> getComments(int postId) async {
    final response = await apiService.getCollectionData<CommentModel>(
      endpoint: 'posts/$postId/comments',
      converter: CommentModel.fromJson,
    );
    return response;
  }

  Future<void> deletePost(int postId) async {
    await apiService.delete(endpoint: 'posts/$postId');
  }

  Future<void> deleteComment(int commentId) async {
    await apiService.delete(endpoint: 'comments/$commentId');
  }
}
