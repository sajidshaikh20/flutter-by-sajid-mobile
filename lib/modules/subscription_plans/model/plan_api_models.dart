class PlanPriceResponse {
  final String currencyCode;
  final double price;

  PlanPriceResponse({
    required this.currencyCode,
    required this.price,
  });

  factory PlanPriceResponse.fromJson(Map<String, dynamic> json) {
    return PlanPriceResponse(
      currencyCode: json['currencyCode'] ?? 'USD',
      price: json['price'] != null ? double.parse(json['price'].toString()) : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'currencyCode': currencyCode,
      'price': price,
    };
  }
}

class PlanResponse {
  final int id;
  final String publicId;
  final String planCode;
  final String planName;
  final String category;
  final String billingCycle;
  final String description;
  final List<PlanPriceResponse> prices;
  final int durationDays;
  final bool isActive;

  PlanResponse({
    required this.id,
    required this.publicId,
    required this.planCode,
    required this.planName,
    required this.category,
    required this.billingCycle,
    required this.description,
    required this.prices,
    required this.durationDays,
    required this.isActive,
  });

  factory PlanResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> pricesList = json['prices'] as List<dynamic>? ?? <dynamic>[];
    List<PlanPriceResponse> parsedPrices = <PlanPriceResponse>[];
    if (pricesList.isNotEmpty) {
      parsedPrices = pricesList
          .map((dynamic p) => PlanPriceResponse.fromJson(p as Map<String, dynamic>))
          .toList();
    } else if (json['price'] != null) {
      parsedPrices = <PlanPriceResponse>[
        PlanPriceResponse(
          currencyCode: json['currencyCode'] ?? 'USD',
          price: json['price'] != null ? double.parse(json['price'].toString()) : 0.0,
        ),
      ];
    }

    return PlanResponse(
      id: json['id'] != null ? int.parse(json['id'].toString()) : 0,
      publicId: json['publicId'] ?? '',
      planCode: json['planCode'] ?? '',
      planName: json['planName'] ?? '',
      category: json['category'] ?? '',
      billingCycle: json['billingCycle'] ?? '',
      description: json['description'] ?? '',
      prices: parsedPrices,
      durationDays: json['durationDays'] ?? 30,
      isActive: json['active'] ?? json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'publicId': publicId,
      'planCode': planCode,
      'planName': planName,
      'category': category,
      'billingCycle': billingCycle,
      'description': description,
      'prices': prices.map((PlanPriceResponse p) => p.toJson()).toList(),
      'durationDays': durationDays,
      'isActive': isActive,
    };
  }
}

class CreateSubscriptionRequest {
  final String userPublicId;
  final int planId;

  CreateSubscriptionRequest({
    required this.userPublicId,
    required this.planId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userPublicId': userPublicId,
      'planId': planId,
    };
  }
}
