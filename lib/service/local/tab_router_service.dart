import 'package:flutter/material.dart';

/// A service responsible for managing the context for tab navigation.
///
/// This service stores the `BuildContext` for tab-based routing in a variable
/// and provides an easy way to access it for navigation purposes.
class TabRouterService {
  /// The context for tab navigation.
  ///
  /// This context is used for navigation within the tabs of the application,
  /// enabling access to routes and navigation within the specific tab.
  BuildContext? tabsRouterContext;
}
