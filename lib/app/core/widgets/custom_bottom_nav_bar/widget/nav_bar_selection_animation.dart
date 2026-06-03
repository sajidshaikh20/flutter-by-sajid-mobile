import 'package:flutter/material.dart';

import '../../../theme/dimens.dart';

/// Shared timing for bottom-nav active/inactive transitions.
abstract final class NavBarSelectionAnimation {
  static const Duration duration =
      Duration(milliseconds: Dimens.milliseconds300);

  static const Curve curve = Curves.easeOutCubic;
}
