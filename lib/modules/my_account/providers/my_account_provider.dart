import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../state/my_account_state.dart';

/// Notifier for managing my account state (Riverpod version).
class MyAccountNotifier extends StateNotifier<MyAccountState> {
  /// Creates a [MyAccountNotifier] instance.
  MyAccountNotifier({
    required this.repository,
    required MyAccountState initialState,
  }) : super(initialState) {
    // Business logic commented out for base template
    // _checkLoginStatus();
    // scheduleMicrotask(() async => callLoyaltyPointsApi());
  }

  final MyAccountRepositoryImpl repository;

  /// Fetches initial data - commented out for base template
  Future<void> getInitialData() async {
    // Business logic commented out for base template
    // await _callCMSApi();
    // await callAccountDetails();
  }

  /// Call loyalty points API - commented out for base template
  Future<void> callLoyaltyPointsApi() async {
    // Business logic commented out for base template
  }

  /// Call account details API - commented out for base template
  Future<void> callAccountDetails() async {
    // Business logic commented out for base template
  }

  /// Logout functionality - commented out for base template
  Future<void> logout() async {
    // Business logic commented out for base template
  }

  /// Update profile functionality - commented out for base template
  Future<void> updateProfile() async {
    // Business logic commented out for base template
  }
}

/// Provider for MyAccountRepository.
final Provider<MyAccountRepositoryImpl> myAccountRepositoryProvider =
    Provider<MyAccountRepositoryImpl>((ProviderRef<MyAccountRepositoryImpl> ref) {
  return MyAccountRepositoryImpl();
});

/// Provider for MyAccountNotifier (auto-dispose for page-level instances).
final AutoDisposeStateNotifierProviderFamily<MyAccountNotifier, MyAccountState, MyAccountState> myAccountNotifierProvider =
    StateNotifierProvider.autoDispose.family<MyAccountNotifier, MyAccountState, MyAccountState>(
  (AutoDisposeStateNotifierProviderRef<MyAccountNotifier, MyAccountState> ref, MyAccountState initialState) {
    final MyAccountRepositoryImpl repository = ref.watch(myAccountRepositoryProvider);
    return MyAccountNotifier(repository: repository, initialState: initialState);
  },
);

