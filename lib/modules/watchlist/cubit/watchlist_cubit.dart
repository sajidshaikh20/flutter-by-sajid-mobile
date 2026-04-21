import '../../../utils/exports.dart';

/// Cubit responsible for watchlist stock ordering.
class WatchlistCubit extends BaseCubit<WatchlistState> {
  WatchlistCubit() : super(WatchlistState.initial()) {
    _loadSampleStocks();
  }

  void _loadSampleStocks() {
    emit(
      state.copyWith(
        status: BaseStateStatus.success,
        stocks: const <WatchlistStockModel>[
          WatchlistStockModel(
            id: 'AAPL',
            name: 'Apple Inc.',
            price: 224.80,
            changePercentage: 1.25,
          ),
          WatchlistStockModel(
            id: 'TSLA',
            name: 'Tesla, Inc.',
            price: 179.40,
            changePercentage: -0.95,
          ),
          WatchlistStockModel(
            id: 'NVDA',
            name: 'NVIDIA Corp.',
            price: 937.65,
            changePercentage: 2.41,
          ),
          WatchlistStockModel(
            id: 'MSFT',
            name: 'Microsoft Corp.',
            price: 420.30,
            changePercentage: 0.72,
          ),
          WatchlistStockModel(
            id: 'AMZN',
            name: 'Amazon.com Inc.',
            price: 182.55,
            changePercentage: -0.14,
          ),
        ],
      ),
    );
  }

  /// Reorder event handler for [ReorderableListView].
  void onStocksReordered(int oldIndex, int newIndex) {
    final List<WatchlistStockModel> updatedStocks =
        List<WatchlistStockModel>.from(state.stocks);

    // ReorderableListView uses the post-removal index; adjust it for downward moves.
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final WatchlistStockModel movedItem = updatedStocks.removeAt(oldIndex);
    updatedStocks.insert(newIndex, movedItem);

    emit(state.copyWith(
        stocks: List<WatchlistStockModel>.unmodifiable(updatedStocks)));
  }

  @override
  WatchlistState getResetErrorState() => state.copyWith(msg: '');

  @override
  WatchlistState getResetRedirectionState() => state.copyWith();
}
