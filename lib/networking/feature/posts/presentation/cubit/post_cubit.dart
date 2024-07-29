// ignore_for_file: sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:network_app/networking/feature/posts/data/models/post_model.dart';
import 'package:network_app/networking/feature/posts/domain/usecases/get_posts_usecase.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final GetPostsUseCase getPostsUseCase;

  PostCubit(this.getPostsUseCase) : super(PostInitial());

  Future<void> fetchPosts() async {
    try {
      emit(PostLoading());
      final posts = await getPostsUseCase();
      emit(PostLoaded(posts: posts));
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }
}
