part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {

  const PostLoaded({required this.posts});
  final List<PostModel> posts;

  @override
  List<Object> get props => [posts];
}

class PostError extends PostState {

  const PostError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
