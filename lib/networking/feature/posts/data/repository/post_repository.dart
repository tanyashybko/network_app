import 'package:network_app/networking/api/api_service.dart';
import 'package:network_app/networking/api/endpoints/posts_endpoint.dart';
import 'package:network_app/networking/feature/posts/data/models/comment_model.dart';
import 'package:network_app/networking/feature/posts/data/models/post_model.dart';

class PostRepository {
  PostRepository({required this.apiService});
  final ApiService apiService;

  Future<PostModel> getPost(int postId) async {
    final response = await apiService.get<PostModel>(
      endpoint: '${PostsEndpoint.allPosts.path}/$postId',
      converter: PostModel.fromJson,
    );
    return response!;
  }

  Future<List<CommentModel>> getComments(int postId) async {
    final response = await apiService.getCollectionData<CommentModel>(
      endpoint: '${PostsEndpoint.allPosts.path}/$postId/comments',
      converter: CommentModel.fromJson,
    );
    return response;
  }

  Future<List<PostModel>> getPosts() async {
    final response = await apiService.getCollectionData<PostModel>(
      endpoint: PostsEndpoint.allPosts.path,
      converter: PostModel.fromJson,
    );
    return response;
  }
}
