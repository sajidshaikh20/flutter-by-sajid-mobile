import '../../utils/exports.dart';

/// A singleton service for handling analytics events and data.

class AnalyticsService {
  /// The singleton instance of the [AnalyticsService].
  /// This factory constructor ensures that only one instance of the service
  /// exists throughout the app's lifecycle.
  factory AnalyticsService() => instance;

  AnalyticsService._internal();

  /// Singleton pattern: Ensures only
  ///   one instance of AnalyticsService is created.
  static final AnalyticsService instance = AnalyticsService._internal();

  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Initializes the analytics service by enabling
  /// Firebase Analytics collection.
  Future<void> init() async {
    /// Enables analytics collection for Firebase Analytics.
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  }

  /// Sets the user ID for Firebase Analytics.
  Future<void> setUserId() async {
    await _analytics.setUserId(id: getIt<UserProfileService>().customerName);
  }

  /// Logs a Firebase login event.
  ///
  /// [method]: The login method used (e.g., 'email', 'google').
  Future<void> logFirebaseLoginEvent(String method) async {
    await logCustomEvent(
      name: AppAnalyticsConstant.login,
      parameters: <String, Object?>{AppAnalyticsConstant.method: method},
    );
  }

  /// Logs a Firebase signup event.
  ///
  /// [method]: The signup method used (e.g., 'email', 'facebook').
  Future<void> signupFirebaseEvent(String method) async {
    await logCustomEvent(
      name: AppAnalyticsConstant.signUp,
      parameters: <String, Object?>{AppAnalyticsConstant.method: method},
    );
  }

  /// Logs a view item event.
  ///
  /// [itemName]: The name of the item viewed.
  /// [itemPrice]: The price of the item viewed.
  /// [itemSku]: The SKU (Stock Keeping Unit) of the item viewed.
  Future<void> logViewItemEvent({
    required String itemName,
    required double itemPrice,
    required String itemSku,
  }) async {
    await logCustomEvent(
      name: AppAnalyticsConstant.viewItem,
      parameters: <String, Object?>{
        AppAnalyticsConstant.itemId: itemSku,
        AppAnalyticsConstant.itemName: itemName,
        AppAnalyticsConstant.price: itemPrice,
      },
    );
  }

  /// Logs a view item list event.
  ///
  /// [productDetails]: A list of products in the item list.
  /// [itemListName]: The name of the item list being viewed.
  Future<void> viewItemListFirebaseEvent({
    required List<ProductList>? productDetails,
    required String itemListName,
  }) async {
    if (productDetails == null || productDetails.isEmpty) {
      return;
    }

    List<Map<String, Object?>> itemDetails = productDetails
        .map(
          (ProductList product) => <String, Object?>{
            AppAnalyticsConstant.itemName: product.name,
            AppAnalyticsConstant.itemId: product.sku,
            AppAnalyticsConstant.price: product.price,
          },
        )
        .toList();

    Map<String, Object> eventParams = <String, Object>{
      AppAnalyticsConstant.items: itemDetails, // Pass the list directly
      AppAnalyticsConstant.currency: getIt<LanguageService>().defaultCurrency,
    };

    await logCustomEvent(
      name: AppAnalyticsConstant.viewItemList,
      parameters: eventParams,
    );
  }

  /// Logs a view cart event.
  ///
  /// [cartViewModel]: The cart details
  /// including items, names, SKUs, and prices.


  /// Logs a begin checkout event.
  ///
  /// [items]: The order review details including
  ///  product names, SKUs, and prices.
  Future<void> beginCheckoutFirebaseEvent({
    required OrderReviewData items,
  }) async {
    List<Map<String, dynamic>> itemDetails = items.items!
        .map(
          (Item item) => <String, Object?>{
            AppAnalyticsConstant.itemName: item.productName,
            AppAnalyticsConstant.itemId: item.sku,
            AppAnalyticsConstant.price: item.unformattedPrice,
          },
        )
        .toList();

    Map<String, Object> eventParams = <String, Object>{
      AppAnalyticsConstant.items: itemDetails,
      AppAnalyticsConstant.eventActionField: '{step: 2}',
    };

    await logCustomEvent(
      name: AppAnalyticsConstant.beginCheckout,
      parameters: eventParams,
    );
  }

  /// Logs a purchase event.
  ///
  /// [items]: A list of purchased items.
  /// [userId]: The ID of the user making the purchase.
  /// [transactionId]: The transaction ID of the purchase.
  /// [totalAmount]: The total amount of the purchase.
  /// [taxCharged]: The tax charged for the purchase.
  /// [shippingCharges]: The shipping charges for the purchase.
  /// [discountAmount]: The discount applied to the purchase.
  /// [couponCode]: The coupon code applied to the purchase.
  /// [currencyCode]: The currency code of the purchase.
  Future<void> purchaseFirebaseEvent({
    required List<Item> items,
    required String userId,
    required String transactionId,
    required double totalAmount,
    required String taxCharged,
    required String shippingCharges,
    required String discountAmount,
    required String couponCode,
    required String currencyCode,
  }) async {
    List<Map<String, Object?>> itemDetails = items
        .map(
          (Item item) => <String, Object?>{
            AppAnalyticsConstant.itemName: item.productName,
            AppAnalyticsConstant.itemId: item.sku,
            AppAnalyticsConstant.price: item.unformattedPrice,
          },
        )
        .toList();

    Map<String, Object> eventParams = <String, Object>{
      AppAnalyticsConstant.items: itemDetails,
      AppAnalyticsConstant.userId: userId,
      AppAnalyticsConstant.transactionId: transactionId,
      AppAnalyticsConstant.affiliation: AppConstant.appName,
      AppAnalyticsConstant.value: totalAmount,
      AppAnalyticsConstant.tax: taxCharged,
      AppAnalyticsConstant.shipping: shippingCharges,
      AppAnalyticsConstant.discount: discountAmount,
      AppAnalyticsConstant.coupom: couponCode,
      AppAnalyticsConstant.currency: currencyCode,
    };

    await logCustomEvent(
      name: AppAnalyticsConstant.purchase,
      parameters: eventParams,
    );
  }

  /// Logs an add-to-cart event.
  ///
  /// [itemName]: The name of the item being added to the cart.
  /// [itemPrice]: The price of the item being added.
  /// [itemSku]: The SKU of the item being added.
  /// [currencyCode]: The currency code of the item's price.
  Future<void> addToCartFirebaseEvent({
    required String itemName,
    required String itemPrice, // Fix: This should be a number
    required String itemSku,
    required String currencyCode,
  }) async {
    Map<String, Object> itemParams = <String, Object>{
      AppAnalyticsConstant.itemId: itemSku,
      AppAnalyticsConstant.itemName: itemName,
      AppAnalyticsConstant.price: double.tryParse(itemPrice) ?? 0.0,
      // Convert to number
      AppAnalyticsConstant.currency: currencyCode,
    };

    Map<String, Object> eventParams = <String, Object>{
      AppAnalyticsConstant.items: <Map<String, Object>>[itemParams],
    };

    await logCustomEvent(
      name: AppAnalyticsConstant.addToCart,
      parameters: eventParams,
    );
  }

  /// Logs a remove-from-cart event.
  ///
  /// [itemName]: The name of the item being removed from the cart.
  /// [itemPrice]: The price of the item being removed.
  /// [itemSku]: The SKU of the item being removed.
  /// [currencyCode]: The currency code of the item's price.
  Future<void> removeFromCartFirebaseEvent({
    required String itemName,
    required double itemPrice,
    required String itemSku,
    required String currencyCode,
  }) async {
    Map<String, Object> itemParams = <String, Object>{
      AppAnalyticsConstant.itemId: itemSku,
      AppAnalyticsConstant.itemName: itemName,
      AppAnalyticsConstant.price: itemPrice,
      AppAnalyticsConstant.currency: currencyCode,
    };

    Map<String, Object> eventParams = <String, Object>{
      AppAnalyticsConstant.items: <Map<String, Object>>[itemParams],
    };

    await logCustomEvent(
      name: AppAnalyticsConstant.removeFromCart,
      parameters: eventParams,
    );
  }

  /// Logs a custom analytics event.
  ///
  /// [name]: The name of the custom event.
  /// [parameters]: A map of parameters associated with the event.
  Future<void> logCustomEvent({
    required String name,
    required Map<String, Object?> parameters,
  }) async {
    try {
      Map<String, Object> defaultParameters = <String, Object>{
        AppAnalyticsConstant.source: getPlatformSource(),
        AppAnalyticsConstant.eventTime: '${DateTime.now().toLocal()}',
      };
      parameters.addAll(defaultParameters);
      Map<String, Object> sanitizedParameters = <String, Object>{};

      parameters.forEach((String key, Object? value) {
        if (value != null) {
          if (value is String ||
              value is int ||
              value is double ||
              value is bool) {
            sanitizedParameters[key] = value;
          } else if (value is List<Map<String, Object?>>) {
            // Convert list of maps to a JSON string
            sanitizedParameters[key] = value
                .map((Map<String, Object?> item) {
                  return item.map((String k, Object? v) => MapEntry<String, Object>(k, v ?? ''));
                })
                .toList()
                .toString();
          } else {
            debugPrint('Invalid parameter type for $key: $value');
          }
        }
      });
      await _analytics.logEvent(
        name: name,
        parameters: sanitizedParameters,
      );
      debugPrint('addFirebaseCustomEvent: $name, $sanitizedParameters');
    } on Exception catch (error) {
      debugPrint('Error logging event: $error');
    }
  }

  /// Retrieves the platform-specific source (e.g., 'iOS' or 'Android').
  String getPlatformSource() =>
      Platform.isIOS ? AppConstant.ios : AppConstant.android;
}
