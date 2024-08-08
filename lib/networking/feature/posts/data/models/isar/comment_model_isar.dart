import 'package:isar/isar.dart';

part 'comment_model_isar.g.dart';

@Collection()
class CommentModelIsar {
  @Id()
  int? id;

  late int postId;
  late String name;
  late String body;
}
