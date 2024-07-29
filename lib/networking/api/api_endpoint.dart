import 'package:flutter/material.dart';
import 'package:network_app/networking/api/endpoints/posts_endpoint.dart';

@immutable
class ApiEndpoint {
  const ApiEndpoint(this.baseUrl);

  final String baseUrl;

  static String posts(PostsEndpoint endpoint) => endpoint.path;
}
