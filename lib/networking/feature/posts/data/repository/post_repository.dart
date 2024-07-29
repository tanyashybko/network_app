import 'package:network_app/networking/api/api_service.dart';
import 'package:network_app/networking/feature/posts/data/models/post_model.dart';

class PostRepository {

  PostRepository({required this.apiService});
  final ApiService apiService;

  Future<List<PostModel>> getPosts() async {
    final response = await apiService.getCollectionData<PostModel>(
      endpoint: 'https://jsonplaceholder.typicode.com/posts',
      converter: PostModel.fromJson,
    );
    return response;
  }
}
