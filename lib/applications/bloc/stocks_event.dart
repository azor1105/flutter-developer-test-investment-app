import 'package:equatable/equatable.dart';
import '../../domain/entities/stocks_filter.dart';
import '../../domain/entities/pagination_params.dart';

abstract class StocksEvent extends Equatable {
  const StocksEvent();

  @override
  List<Object?> get props => [];
}

class LoadStocksEvent extends StocksEvent {
  final StocksFilter? filter;
  final PaginationParams? pagination;
  final bool isRefresh;

  const LoadStocksEvent({
    this.filter,
    this.pagination,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [filter, pagination, isRefresh];
}

class SearchStocksEvent extends StocksEvent {
  final String query;
  final StocksFilter? additionalFilter;

  const SearchStocksEvent(
    this.query, {
    this.additionalFilter,
  });

  @override
  List<Object?> get props => [query, additionalFilter];
}

class FilterStocksEvent extends StocksEvent {
  final StocksFilter filter;

  const FilterStocksEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}

class LoadMoreStocksEvent extends StocksEvent {
  const LoadMoreStocksEvent();
}

class RefreshStocksEvent extends StocksEvent {
  const RefreshStocksEvent();
}

class ClearSearchEvent extends StocksEvent {
  const ClearSearchEvent();
}
