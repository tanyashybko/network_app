import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:network_app/networking/dio_service.dart';

abstract class ApiService {
  Future<T?> get<T>({
    required String endpoint,
    required T Function(Map<String, dynamic> response) converter,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
  });

  Future<List<T>> getCollectionData<T>({
    required String endpoint,
    required T Function(Map<String, dynamic> responseBody) converter,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
  });

  Future<void> delete({required String endpoint});
}

class ApiServiceImpl implements ApiService {
  ApiServiceImpl(this._dioService);

  final DioService _dioService;

  @override
  Future<T?> get<T>({
    required String endpoint,
    required T Function(Map<String, dynamic> response) converter,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
  }) async {
    try {
      final data = await _dioService.get<T>(
        endpoint: endpoint,
        converter: converter,
        queryParams: queryParams,
        cancelToken: cancelToken,
      );
      return data;
    } on Exception catch (ex) {
      debugPrint(ex.toString());
      rethrow;
    }
  }

  @override
  Future<List<T>> getCollectionData<T>({
    required String endpoint,
    required T Function(Map<String, dynamic> responseBody) converter,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
  }) async {
    try {
      final data = await _dioService.getCollectionData<T>(
        endpoint: endpoint,
        converter: converter,
        queryParams: queryParams,
        cancelToken: cancelToken,
      );

      return data;
    } on Exception catch (ex) {
      debugPrint(ex.toString());
      rethrow;
    }
  }

  @override
  Future<void> delete({required String endpoint}) async {
    try {
      await _dioService.delete(endpoint: endpoint);
    } on Exception catch (ex) {
      debugPrint(ex.toString());
      rethrow;
    }
  }
}
