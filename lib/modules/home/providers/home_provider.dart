import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../state/home_state.dart';
import '../repo/home_repository.dart';

/// Notifier for managing home screen state (Riverpod version).
class HomeNotifier extends StateNotifier<HomeState> {
  /// Creates a [HomeNotifier] instance.
  HomeNotifier({
    required this.homeRepository,
  }) : super(HomeState.initial());

  /// Repository for handling home-related API calls and data.
  final HomeRepository homeRepository;

  /// Initializes the home screen data - commented out for base template
  void initData() {
    // Business logic commented out for base template
  }

  /// Initializes the segment index - commented out for base template
  void initializeSegmentIndex() {
    // Business logic commented out for base template
  }

  /// Refreshes the home screen data - commented out for base template
  void refreshHomeData() {
    // Business logic commented out for base template
  }
}

/// Provider for HomeRepository.
final Provider<HomeRepository> homeRepositoryProvider =
    Provider<HomeRepository>((ProviderRef<HomeRepository> ref) {
  return HomeRepositoryImpl();
});

/// Provider for HomeNotifier.
final AutoDisposeStateNotifierProvider<HomeNotifier, HomeState> homeNotifierProvider =
    StateNotifierProvider.autoDispose<HomeNotifier, HomeState>(
  (AutoDisposeStateNotifierProviderRef<HomeNotifier, HomeState> ref) {
    final HomeRepository repository = ref.watch(homeRepositoryProvider);
    return HomeNotifier(homeRepository: repository);
  },
);

