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
      final data = await _dioService.get<Map<String, dynamic>>(
        endpoint: endpoint,
        queryParams: queryParams,
        cancelToken: cancelToken,
      );

      if (data == null) {
        return null;
      } else {
        return converter(data);
      }
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
      final data = await _dioService.get<List<dynamic>>(
        endpoint: endpoint,
        queryParams: queryParams,
        cancelToken: cancelToken,
      );

      if (data == null) {
        return [];
      } else {
        return data
            .map(
              (dynamic dataMap) => converter(dataMap as Map<String, dynamic>),
            )
            .toList();
      }
    } on Exception catch (ex) {
      debugPrint(ex.toString());
      rethrow;
    }
  }
}
