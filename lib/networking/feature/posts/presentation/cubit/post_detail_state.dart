part of 'post_detail_cubit.dart';

abstract class PostDetailState extends Equatable {
  const PostDetailState();

  @override
  List<Object?> get props => [];
}

class PostDetailInitial extends PostDetailState {}

class PostDetailLoading extends PostDetailState {}

class PostDetailLoaded extends PostDetailState {

  const PostDetailLoaded({required this.post, required this.comments});
  final PostModel post;
  final List<CommentModel> comments;

  @override
  List<Object?> get props => [post, comments];
}

class PostDetailError extends PostDetailState {

  const PostDetailError({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}

class PostDeleted extends PostDetailState {}
