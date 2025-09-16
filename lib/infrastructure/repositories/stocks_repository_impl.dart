import '../../domain/repositories/stocks_repository.dart';
import '../../domain/entities/stocks_filter.dart';
import '../../domain/entities/pagination_params.dart';
import '../datasources/stocks_api_datasource.dart';

class StocksRepositoryImpl implements StocksRepository {
  final StocksApiDataSource _apiDataSource;

  StocksRepositoryImpl({
    required StocksApiDataSource apiDataSource,
  }) : _apiDataSource = apiDataSource;

  @override
  Future<StocksListResult> getStocksList({
    StocksFilter? filter,
    PaginationParams? pagination,
  }) async {
    try {
      final response = await _apiDataSource.getStocksList(
        filter: filter,
        pagination: pagination,
      );

      final stocks =
          response.data.map((stockModel) => stockModel.toEntity()).toList();

      return StocksListResult(
        stocks: stocks,
      );
    } catch (e) {
      // You can add logging here if needed
      rethrow;
    }
  }
}
