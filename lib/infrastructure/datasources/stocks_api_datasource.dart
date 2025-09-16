import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/stocks_list_response.dart';
import '../../domain/entities/stocks_filter.dart';
import '../../domain/entities/pagination_params.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, [this.statusCode]);

  @override
  String toString() =>
      'ApiException: $message${statusCode != null ? ' (Code: $statusCode)' : ''}';
}

class StocksApiDataSource {
  static const String _baseUrl = 'https://dev.codeunion.kz/ailat/api';
  static const String _stocksEndpoint = '$_baseUrl/stocks/list';

  final http.Client _client;

  StocksApiDataSource({http.Client? client})
      : _client = client ?? http.Client();

  Future<StocksListResponse> getStocksList({
    StocksFilter? filter,
    PaginationParams? pagination,
  }) async {
    try {
      final uri = _buildUri(filter: filter, pagination: pagination);

      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return StocksListResponse.fromJson(jsonData);
      } else {
        throw ApiException(
          'Failed to fetch stocks list: ${response.reasonPhrase}',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  Uri _buildUri({
    StocksFilter? filter,
    PaginationParams? pagination,
  }) {
    final Map<String, String> queryParams = {};

    // Add filter parameters
    if (filter != null) {
      queryParams.addAll(filter.toQueryParams());
    }

    // Add pagination parameters
    if (pagination != null) {
      queryParams.addAll(pagination.toQueryParams());
    } else {
      // Default pagination
      queryParams.addAll(const PaginationParams().toQueryParams());
    }

    return Uri.parse(_stocksEndpoint).replace(queryParameters: queryParams);
  }

  void dispose() {
    _client.close();
  }
}
