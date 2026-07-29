class ClientSummaryModel {
  final String publicId;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String profilePictureUrl;

  ClientSummaryModel({
    required this.publicId,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.profilePictureUrl,
  });

  factory ClientSummaryModel.fromJson(Map<String, dynamic> json) {
    return ClientSummaryModel(
      publicId: json['publicId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      profilePictureUrl: json['profilePictureUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'publicId': publicId,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}

class TradeWithClientsModel {
  final String tradePublicId;
  final String market;
  final String currencyPairSymbol;
  final String marketType;
  final String status;
  final String? createdAt;
  final String note;
  final List<ClientSummaryModel> clients;

  TradeWithClientsModel({
    required this.tradePublicId,
    required this.market,
    required this.currencyPairSymbol,
    required this.marketType,
    required this.status,
    this.createdAt,
    required this.note,
    required this.clients,
  });

  factory TradeWithClientsModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> clientsList = json['clients'] as List<dynamic>? ?? <dynamic>[];
    return TradeWithClientsModel(
      tradePublicId: json['tradePublicId']?.toString() ?? '',
      market: json['market']?.toString() ?? '',
      currencyPairSymbol: json['currencyPairSymbol']?.toString() ?? '',
      marketType: json['marketType']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdAt: json['createdAt']?.toString(),
      note: json['note']?.toString() ?? '',
      clients: clientsList
          .map((dynamic c) => ClientSummaryModel.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tradePublicId': tradePublicId,
      'market': market,
      'currencyPairSymbol': currencyPairSymbol,
      'marketType': marketType,
      'status': status,
      'createdAt': createdAt,
      'note': note,
      'clients': clients.map((ClientSummaryModel c) => c.toJson()).toList(),
    };
  }
}
