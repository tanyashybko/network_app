import 'package:isar/isar.dart';
import 'package:network_app/networking/feature/posts/data/models/isar/comment_model_isar.dart';

part 'post_model_isar.g.dart';

@Collection()
class PostModelIsar {

  PostModelIsar({
    required this.id,
    required this.title,
    required this.body,
  });
  @Id()
  int? id;

  late String title;
  late String body;

  final comments = IsarLinks<CommentModelIsar>();
}
