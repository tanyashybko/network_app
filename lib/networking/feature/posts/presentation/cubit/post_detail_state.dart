part of 'post_detail_cubit.dart';

abstract class PostDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostDetailInitial extends PostDetailState {}

class PostDetailLoading extends PostDetailState {}

class PostDetailLoaded extends PostDetailState {

  PostDetailLoaded({required this.post, required this.comments});
  final PostModel post;
  final List<CommentModel> comments;

  @override
  List<Object?> get props => [post, comments];
}

class PostDetailError extends PostDetailState {

  PostDetailError({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
