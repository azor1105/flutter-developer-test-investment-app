import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/stocks_usecases.dart';
import '../../domain/entities/stock_entity.dart';
import '../../domain/entities/pagination_params.dart';
import '../../infrastructure/datasources/stocks_api_datasource.dart';
import 'stocks_event.dart';
import 'stocks_state.dart';

class StocksBloc extends Bloc<StocksEvent, StocksState> {
  final GetStocksListUseCase _getStocksListUseCase;
  final SearchStocksUseCase _searchStocksUseCase;

  static const int _perPage = 20;
  Timer? _debounceTimer;

  StocksBloc({
    required GetStocksListUseCase getStocksListUseCase,
    required SearchStocksUseCase searchStocksUseCase,
  })  : _getStocksListUseCase = getStocksListUseCase,
        _searchStocksUseCase = searchStocksUseCase,
        super(const StocksInitial()) {
    on<LoadStocksEvent>(_onLoadStocks);
    on<SearchStocksEvent>(_onSearchStocks);
    on<FilterStocksEvent>(_onFilterStocks);
    on<LoadMoreStocksEvent>(_onLoadMoreStocks);
    on<RefreshStocksEvent>(_onRefreshStocks);
    on<ClearSearchEvent>(_onClearSearch);
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }

  Future<void> _onLoadStocks(
    LoadStocksEvent event,
    Emitter<StocksState> emit,
  ) async {
    if (event.isRefresh && state is StocksLoaded) {
      // Don't show loading for refresh
    } else {
      emit(const StocksLoading());
    }

    try {
      final result = await _getStocksListUseCase.call(
        filter: event.filter,
        pagination: event.pagination ??
            const PaginationParams(page: 1, perPage: _perPage),
      );

      if (result.stocks.isEmpty) {
        emit(const StocksEmpty('No stocks found'));
      } else {
        emit(StocksLoaded(
          stocks: result.stocks,
          hasReachedMax: result.stocks.length < _perPage,
          currentPage: event.pagination?.page ?? 1,
        ));
      }
    } catch (e) {
      String errorMessage = 'Failed to load stocks';
      if (e is ApiException) {
        errorMessage = e.message;
      }

      if (state is StocksLoaded && event.isRefresh) {
        emit(StocksError(errorMessage,
            previousStocks: (state as StocksLoaded).stocks));
      } else {
        emit(StocksError(errorMessage));
      }
    }
  }

  Future<void> _onSearchStocks(
    SearchStocksEvent event,
    Emitter<StocksState> emit,
  ) async {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (event.query.trim().isEmpty) {
        add(const LoadStocksEvent());
        return;
      }

      emit(const StocksLoading());

      try {
        final result = await _searchStocksUseCase.call(
          searchQuery: event.query,
          additionalFilter: event.additionalFilter,
          pagination: const PaginationParams(page: 1, perPage: _perPage),
        );

        if (result.stocks.isEmpty) {
          emit(StocksEmpty('No stocks found for "${event.query}"'));
        } else {
          emit(StocksLoaded(
            stocks: result.stocks,
            hasReachedMax: result.stocks.length < _perPage,
            currentSearchQuery: event.query,
            currentPage: 1,
          ));
        }
      } catch (e) {
        String errorMessage = 'Failed to search stocks';
        if (e is ApiException) {
          errorMessage = e.message;
        }
        emit(StocksError(errorMessage));
      }
    });
  }

  Future<void> _onFilterStocks(
    FilterStocksEvent event,
    Emitter<StocksState> emit,
  ) async {
    add(LoadStocksEvent(
      filter: event.filter,
      pagination: const PaginationParams(page: 1, perPage: _perPage),
    ));
  }

  Future<void> _onLoadMoreStocks(
    LoadMoreStocksEvent event,
    Emitter<StocksState> emit,
  ) async {
    final currentState = state;
    if (currentState is! StocksLoaded ||
        currentState.hasReachedMax ||
        currentState.isLoadingMore) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentState.currentPage + 1;
      final pagination = PaginationParams(page: nextPage, perPage: _perPage);

      late final result;
      if (currentState.currentSearchQuery != null) {
        result = await _searchStocksUseCase.call(
          searchQuery: currentState.currentSearchQuery!,
          pagination: pagination,
        );
      } else {
        result = await _getStocksListUseCase.call(
          pagination: pagination,
        );
      }

      final allStocks = List<StockEntity>.from(currentState.stocks)
        ..addAll(result.stocks);

      emit(StocksLoaded(
        stocks: allStocks,
        hasReachedMax: result.stocks.length < _perPage,
        currentSearchQuery: currentState.currentSearchQuery,
        currentPage: nextPage,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(currentState.copyWith(isLoadingMore: false));
      String errorMessage = 'Failed to load more stocks';
      if (e is ApiException) {
        errorMessage = e.message;
      }
      emit(StocksError(errorMessage, previousStocks: currentState.stocks));
    }
  }

  Future<void> _onRefreshStocks(
    RefreshStocksEvent event,
    Emitter<StocksState> emit,
  ) async {
    final currentState = state;
    if (currentState is StocksLoaded &&
        currentState.currentSearchQuery != null) {
      add(SearchStocksEvent(currentState.currentSearchQuery!));
    } else {
      add(const LoadStocksEvent(isRefresh: true));
    }
  }

  Future<void> _onClearSearch(
    ClearSearchEvent event,
    Emitter<StocksState> emit,
  ) async {
    _debounceTimer?.cancel();
    add(const LoadStocksEvent());
  }
}
