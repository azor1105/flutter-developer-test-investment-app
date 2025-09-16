import 'package:equatable/equatable.dart';
import '../../domain/entities/stock_entity.dart';

abstract class StocksState extends Equatable {
  const StocksState();

  @override
  List<Object?> get props => [];
}

class StocksInitial extends StocksState {
  const StocksInitial();
}

class StocksLoading extends StocksState {
  const StocksLoading();
}

class StocksLoaded extends StocksState {
  final List<StockEntity> stocks;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String? currentSearchQuery;
  final int currentPage;

  const StocksLoaded({
    required this.stocks,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.currentSearchQuery,
    this.currentPage = 1,
  });

  StocksLoaded copyWith({
    List<StockEntity>? stocks,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? currentSearchQuery,
    int? currentPage,
  }) {
    return StocksLoaded(
      stocks: stocks ?? this.stocks,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentSearchQuery: currentSearchQuery ?? this.currentSearchQuery,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [
        stocks,
        hasReachedMax,
        isLoadingMore,
        currentSearchQuery,
        currentPage,
      ];
}

class StocksError extends StocksState {
  final String message;
  final List<StockEntity>? previousStocks;

  const StocksError(
    this.message, {
    this.previousStocks,
  });

  @override
  List<Object?> get props => [message, previousStocks];
}

class StocksEmpty extends StocksState {
  final String message;

  const StocksEmpty(this.message);

  @override
  List<Object?> get props => [message];
}
