import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// A screen that handles navigation between category-related routes.
///
/// This widget uses [AutoRouter] to display the nested routes for
/// category navigation. It acts as a container for the category tab
/// or subcategory pages.
@RoutePage()
class CategoryNavigationScreen extends StatelessWidget {
  /// Creates a [CategoryNavigationScreen].
  const CategoryNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
