import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for cart count state (Riverpod version).
/// Simple StateProvider for managing cart item count.
final StateProvider<int> cartCountProvider = StateProvider<int>((StateProviderRef<int> ref) {
  return 0; // Initial state is 0
});

