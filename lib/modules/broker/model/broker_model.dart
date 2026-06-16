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
