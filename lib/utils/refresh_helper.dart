import 'exports.dart';

/// Helper class to manage refresh functionality across the app
/// This ensures that when users navigate back from other screens,
/// the home screen data is refreshed to show updated wishlist and deals
class RefreshHelper {
  static RefreshHelper? _instance;

  ///instance
  static RefreshHelper get instance => _instance ??= RefreshHelper._();

  RefreshHelper._();

  /// Callback to refresh home data when navigating back
  VoidCallback? _onHomeRefresh;

  /// Register a callback to refresh home data
  void registerHomeRefreshCallback(VoidCallback callback) {
    _onHomeRefresh = callback;
  }

  /// Trigger home refresh
  void refreshHome() {
    _onHomeRefresh?.call();
  }

  /// Clear the refresh callback
  void clearRefreshCallback() {
    _onHomeRefresh = null;
  }
}

/// Extension to easily access refresh helper
extension RefreshHelperExtension on BuildContext {
  /// Get the refresh helper instance
  RefreshHelper get refreshHelper => RefreshHelper.instance;

  /// Refresh home data
  void refreshHomeData() {
    refreshHelper.refreshHome();
  }
}
