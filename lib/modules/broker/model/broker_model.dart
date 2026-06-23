import '../../../utils/exports.dart';

class BrokerModel extends Equatable {
  const BrokerModel({
    required this.id,
    required this.name,
    required this.brokerType,
    required this.badge,
    required this.assets,
    required this.rating,
    required this.ratingText,
    required this.reviewsCount,
    required this.accountsCount,
    required this.logoUrl,
    required this.redirectUrl,
  });

  final String id;
  final String name;
  final String brokerType;
  final String badge;
  final String assets;
  final double rating;
  final String ratingText;
  final String reviewsCount;
  final String accountsCount;
  final String logoUrl;
  final String redirectUrl;

  AssetGenImage get logoAsset {
    switch (id) {
      case 'broker_vantage':
        return Assets.png.vantage;
      case 'broker_vtmarkets':
        return Assets.png.vt;
      case 'broker_pepperstone':
        return Assets.png.pepperstone;
      case 'broker_coinswitch':
        return Assets.png.coinswitch;
      case 'broker_binance':
        return Assets.png.binance;
      case 'broker_lemonn':
        return Assets.png.lemonn;
      case 'broker_arihant':
        return Assets.png.arihant;
      case 'broker_zerodha':
        return Assets.png.zerodha;
      case 'broker_groww':
        return Assets.png.groww;
      case 'broker_angelone':
        return Assets.png.angleone;
      default:
        return Assets.png.icCropWekoIcon;
    }
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        name,
        brokerType,
        badge,
        assets,
        rating,
        ratingText,
        reviewsCount,
        accountsCount,
        logoUrl,
        redirectUrl,
      ];
}
