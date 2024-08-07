// import 'package:dio/dio.dart';
// import 'package:network_app/networking/const.dart';
//
// /// A service class that wraps the [Dio] instance and provides methods for
// /// basic network requests.
// class DioService {
//   /// A public constructor that is used to create a Dio service and initialize
//   /// the underlying [Dio] client.
//   ///
//   /// * [interceptors]: An [Iterable] for attaching custom
//   /// [Interceptor]s to the underlying [_dio] client.
//   /// * [httpClientAdapter]: Replaces the underlying [HttpClientAdapter] with
//   /// this custom one.
//   DioService({
//     required Dio dioClient,
//     Iterable<Interceptor>? interceptors,
//     HttpClientAdapter? httpClientAdapter,
//   })  : _dio = dioClient,
//         _cancelToken = CancelToken() {
//     _dio.options = BaseOptions(baseUrl: baseURL);
//
//     if (interceptors != null) {
//       _dio.interceptors.addAll(interceptors);
//     }
//     if (httpClientAdapter != null) {
//       _dio.httpClientAdapter = httpClientAdapter;
//     }
//   }
//
//   /// An instance of [Dio] for executing network requests.
//   final Dio _dio;
//
//   /// An instance of [CancelToken] used to pre-maturely cancel
//   /// network requests.
//   final CancelToken _cancelToken;
//
//   /// This method invokes the [cancel()] method on either the input
//   /// [cancelToken] or internal [_cancelToken] to pre-maturely end all
//   /// requests attached to this token.
//   void cancelRequests({CancelToken? cancelToken}) {
//     if (cancelToken == null) {
//       _cancelToken.cancel('Cancelled');
//     } else {
//       cancelToken.cancel();
//     }
//   }
//
//   /// This method sends a `GET` request to the [endpoint], **decodes**
//   /// the response and returns a parsed [ResponseModel] with a body of type [R].
//   ///
//   /// Any errors encountered during the request are caught and a custom
//   /// [CustomException] is thrown.
//   ///
//   /// [queryParams] holds any query parameters for the request.
//   ///
//   /// [cancelToken] is used to cancel the request pre-maturely. If null,
//   /// the **default** [cancelToken] inside [DioService] is used.
//   ///
//   /// [cacheOptions] are special cache instructions that can merge and override
//   /// the [globalCacheOptions].
//   ///
//   /// [options] are special instructions that can be merged with the request.
//   Future<R?> get<R>({
//     required String endpoint,
//     Map<String, dynamic>? queryParams,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.get(
//         endpoint,
//         queryParameters: queryParams,
//         options: options,
//         cancelToken: cancelToken ?? _cancelToken,
//       );
//       return response.data as R;
//     } on DioException catch (e) {
//       throw Exception('Network request failed: ${e.message}');
//     }
//   }
//
//   /// This method sends a `DELETE` request to the [endpoint].
//   ///
//   /// Any errors encountered during the request are caught and a custom
//   /// [CustomException] is thrown.
//   ///
//   /// [cancelToken] is used to cancel the request pre-maturely. If null,
//   /// the **default** [cancelToken] inside [DioService] is used.
//   Future<void> delete({
//     required String endpoint,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       await _dio.delete(
//         endpoint,
//         options: options,
//         cancelToken: cancelToken ?? _cancelToken,
//       );
//     } on DioException catch (e) {
//       throw Exception('Network request failed: ${e.message}');
//     }
//   }
//
//   Future<List<T>> getCollectionData<T>({
//     required String endpoint,
//     required T Function(Map<String, dynamic> responseBody) converter,
//     Map<String, dynamic>? queryParams,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.get<List<dynamic>>(
//         endpoint,
//         queryParameters: queryParams,
//         cancelToken: cancelToken ?? _cancelToken,
//       );
//       return response.data!
//           .map((dynamic data) => converter(data as Map<String, dynamic>))
//           .toList();
//     } on DioException catch (e) {
//       throw Exception('Network request failed: ${e.message}');
//     }
//   }
// }


import 'package:dio/dio.dart';
import 'package:network_app/networking/const.dart';

class DioService {
  DioService({
    required Dio dioClient,
    Iterable<Interceptor>? interceptors,
    HttpClientAdapter? httpClientAdapter,
  })  : _dio = dioClient,
        _cancelToken = CancelToken() {
    _dio.options = BaseOptions(baseUrl: baseURL);

    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }
    if (httpClientAdapter != null) {
      _dio.httpClientAdapter = httpClientAdapter;
    }
  }

  final Dio _dio;
  final CancelToken _cancelToken;

  void cancelRequests({CancelToken? cancelToken}) {
    if (cancelToken == null) {
      _cancelToken.cancel('Cancelled');
    } else {
      cancelToken.cancel();
    }
  }

  Future<R?> get<R>({
    required String endpoint,
    required R Function(Map<String, dynamic> response) converter,
    Map<String, dynamic>? queryParams,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        endpoint,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return converter(response.data!);
    } on DioException catch (e) {
      throw Exception('Network request failed: ${e.message}');
    }
  }

  Future<void> delete({
    required String endpoint,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      await _dio.delete<void>(
        endpoint,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
    } on DioException catch (e) {
      throw Exception('Network request failed: ${e.message}');
    }
  }

  Future<List<T>> getCollectionData<T>({
    required String endpoint,
    required T Function(Map<String, dynamic> responseBody) converter,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        endpoint,
        queryParameters: queryParams,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data!
          .map((dynamic data) => converter(data as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Network request failed: ${e.message}');
    }
  }
}
