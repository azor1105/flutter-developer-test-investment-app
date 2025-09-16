import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_investment_app/presentation/assets/asset_index.dart';
import 'package:stock_investment_app/presentation/components/defocus.dart';
import 'package:stock_investment_app/presentation/components/search_bar_x.dart';
import 'package:stock_investment_app/presentation/components/stock_list_item.dart';
import 'package:stock_investment_app/applications/bloc/stocks_bloc.dart';
import 'package:stock_investment_app/applications/bloc/stocks_event.dart';
import 'package:stock_investment_app/applications/bloc/stocks_state.dart';
import 'package:stock_investment_app/domain/usecases/stocks_usecases.dart';
import 'package:stock_investment_app/infrastructure/datasources/stocks_api_datasource.dart';
import 'package:stock_investment_app/infrastructure/repositories/stocks_repository_impl.dart';

class StocksPage extends StatefulWidget {
  const StocksPage({super.key});

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late StocksBloc _stocksBloc;

  @override
  void initState() {
    super.initState();
    _initializeBloc();
    _scrollController.addListener(_onScroll);
  }

  void _initializeBloc() {
    // Initialize dependencies
    final apiDataSource = StocksApiDataSource();
    final repository = StocksRepositoryImpl(apiDataSource: apiDataSource);
    final getStocksUseCase = GetStocksListUseCase(repository: repository);
    final searchStocksUseCase = SearchStocksUseCase(repository: repository);

    _stocksBloc = StocksBloc(
      getStocksListUseCase: getStocksUseCase,
      searchStocksUseCase: searchStocksUseCase,
    );

    // Load initial data
    _stocksBloc.add(const LoadStocksEvent());
  }

  void _onScroll() {
    if (_isBottom) {
      _stocksBloc.add(const LoadMoreStocksEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onSearchChanged(String query) {
    if (query.trim().isEmpty) {
      _stocksBloc.add(const ClearSearchEvent());
    } else {
      _stocksBloc.add(SearchStocksEvent(query));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _stocksBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _stocksBloc,
      child: DeFocus(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Stock Investments',
              style: AppTextStyles.subtitle1,
            ),
            centerTitle: false,
            leading: const BackButton(),
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Search Bar
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.w16,
                    vertical: ScreenSize.h12,
                  ),
                  child: SearchBarX(
                    onChanged: _onSearchChanged,
                    controller: _searchController,
                  ),
                ),

                // Stocks List
                Expanded(
                  child: BlocBuilder<StocksBloc, StocksState>(
                    builder: (context, state) {
                      if (state is StocksLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is StocksError) {
                        return _buildErrorWidget(state);
                      } else if (state is StocksEmpty) {
                        return _buildEmptyWidget(state);
                      } else if (state is StocksLoaded) {
                        return _buildStocksList(state);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(StocksError state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(ScreenSize.w16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: ScreenSize.h40,
              color: Colors.red,
            ),
            SizedBox(height: ScreenSize.h16),
            Text(
              'Error',
              style: AppTextStyles.subtitle1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: ScreenSize.h8),
            Text(
              state.message,
              style: AppTextStyles.bodyText2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ScreenSize.h16),
            ElevatedButton(
              onPressed: () {
                _stocksBloc.add(const RefreshStocksEvent());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget(StocksEmpty state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(ScreenSize.w16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: ScreenSize.h40,
              color: Colors.grey,
            ),
            SizedBox(height: ScreenSize.h16),
            Text(
              'No Stocks Found',
              style: AppTextStyles.subtitle1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: ScreenSize.h8),
            Text(
              state.message,
              style: AppTextStyles.bodyText2.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStocksList(StocksLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        _stocksBloc.add(const RefreshStocksEvent());
      },
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount:
            state.hasReachedMax ? state.stocks.length : state.stocks.length + 1,
        itemBuilder: (context, index) {
          if (index >= state.stocks.length) {
            return state.isLoadingMore
                ? Padding(
                    padding: EdgeInsets.all(ScreenSize.w16),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox.shrink();
          }

          final stock = state.stocks[index];
          return StockListItem(
            stock: stock,
            onTap: () {
              // TODO: Navigate to stock details
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tapped on ${stock.companyName}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
