// ignore_for_file: comment_references

import 'package:dio/dio.dart';

/// A service class that wraps the [Dio] instance and provides methods for
/// basic network requests.
class DioService {
  /// A public constructor that is used to create a Dio service and initialize
  /// the underlying [Dio] client.
  ///
  /// * [interceptors]: An [Iterable] for attaching custom
  /// [Interceptor]s to the underlying [_dio] client.
  /// * [httpClientAdapter]: Replaces the underlying [HttpClientAdapter] with
  /// this custom one.
  DioService({
    required Dio dioClient,
    Iterable<Interceptor>? interceptors,
    HttpClientAdapter? httpClientAdapter,
  })  : _dio = dioClient,
        _cancelToken = CancelToken() {
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }
    if (httpClientAdapter != null) {
      _dio.httpClientAdapter = httpClientAdapter;
    }
  }

  /// An instance of [Dio] for executing network requests.
  final Dio _dio;

  /// An instance of [CancelToken] used to pre-maturely cancel
  /// network requests.
  final CancelToken _cancelToken;

  /// This method invokes the [cancel()] method on either the input
  /// [cancelToken] or internal [_cancelToken] to pre-maturely end all
  /// requests attached to this token.
  void cancelRequests({CancelToken? cancelToken}) {
    if (cancelToken == null) {
      _cancelToken.cancel('Cancelled');
    } else {
      cancelToken.cancel();
    }
  }

  /// This method sends a `GET` request to the [endpoint], **decodes**
  /// the response and returns a parsed [ResponseModel] with a body of type [R].
  ///
  /// Any errors encountered during the request are caught and a custom
  /// [CustomException] is thrown.
  ///
  /// [queryParams] holds any query parameters for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [cacheOptions] are special cache instructions that can merge and override
  /// the [globalCacheOptions].
  ///
  /// [options] are special instructions that can be merged with the request.
  Future<R?> get<R>({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      // ignore: inference_failure_on_function_invocation
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as R;
    // ignore: deprecated_member_use
    } on DioError catch (e) {
      // Handle DioError or rethrow if necessary
      throw Exception('Network request failed: ${e.message}');
    }
  }
}
