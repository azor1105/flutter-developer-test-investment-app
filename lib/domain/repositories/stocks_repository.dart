import '../entities/stock_entity.dart';
import '../entities/stocks_filter.dart';
import '../entities/pagination_params.dart';

class StocksListResult {
  final List<StockEntity> stocks;

  const StocksListResult({
    required this.stocks,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StocksListResult && other.stocks.length == stocks.length;
  }

  @override
  int get hashCode => stocks.hashCode;

  @override
  String toString() =>
      'StocksListResult(stocks: ${stocks.length} items';
}

abstract class StocksRepository {
  Future<StocksListResult> getStocksList({
    StocksFilter? filter,
    PaginationParams? pagination,
  });
}
