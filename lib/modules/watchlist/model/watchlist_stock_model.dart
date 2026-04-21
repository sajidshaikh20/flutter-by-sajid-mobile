import '../../../utils/exports.dart';

/// Immutable stock item used by the watchlist UI.
class WatchlistStockModel extends Equatable {
  const WatchlistStockModel({
    required this.id,
    required this.name,
    required this.price,
    required this.changePercentage,
  });

  final String id;
  final String name;
  final double price;
  final double changePercentage;

  WatchlistStockModel copyWith({
    String? id,
    String? name,
    double? price,
    double? changePercentage,
  }) {
    return WatchlistStockModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      changePercentage: changePercentage ?? this.changePercentage,
    );
  }

  @override
  List<Object?> get props => <Object?>[id, name, price, changePercentage];
}
