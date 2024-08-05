enum PostsEndpoint {
  allPosts('posts'),
  comments('comments');

  const PostsEndpoint(this.path);

  final String path;
}
