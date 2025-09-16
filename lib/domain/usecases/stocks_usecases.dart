import '../repositories/stocks_repository.dart';
import '../entities/stocks_filter.dart';
import '../entities/pagination_params.dart';

class GetStocksListUseCase {
  final StocksRepository _repository;

  GetStocksListUseCase({
    required StocksRepository repository,
  }) : _repository = repository;

  Future<StocksListResult> call({
    StocksFilter? filter,
    PaginationParams? pagination,
  }) async {
    return await _repository.getStocksList(
      filter: filter,
      pagination: pagination,
    );
  }
}

class GetCompliantStocksUseCase {
  final StocksRepository _repository;

  GetCompliantStocksUseCase({
    required StocksRepository repository,
  }) : _repository = repository;

  Future<StocksListResult> call({
    PaginationParams? pagination,
  }) async {
    return await _repository.getStocksList(
      filter: const StocksFilter(compliance: 'true'),
      pagination: pagination,
    );
  }
}

class GetNonCompliantStocksUseCase {
  final StocksRepository _repository;

  GetNonCompliantStocksUseCase({
    required StocksRepository repository,
  }) : _repository = repository;

  Future<StocksListResult> call({
    PaginationParams? pagination,
  }) async {
    return await _repository.getStocksList(
      filter: const StocksFilter(compliance: 'false'),
      pagination: pagination,
    );
  }
}

class SearchStocksUseCase {
  final StocksRepository _repository;

  SearchStocksUseCase({
    required StocksRepository repository,
  }) : _repository = repository;

  Future<StocksListResult> call({
    required String searchQuery,
    StocksFilter? additionalFilter,
    PaginationParams? pagination,
  }) async {
    final filter = StocksFilter(
      search: searchQuery,
      compliance: additionalFilter?.compliance,
      country: additionalFilter?.country,
    );

    return await _repository.getStocksList(
      filter: filter,
      pagination: pagination,
    );
  }
}
