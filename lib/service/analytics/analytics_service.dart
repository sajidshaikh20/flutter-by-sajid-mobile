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
