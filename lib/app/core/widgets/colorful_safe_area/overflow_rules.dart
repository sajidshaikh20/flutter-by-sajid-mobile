/// Determines which edges of the widget can overflow.
class OverflowRules {
  /// All edges can overflow.
  const OverflowRules.all({required bool value})
      : left = value,
        top = value,
        right = value,
        bottom = value;

  /// Vertical and/or horizontal edges can overflow.
  ///
  /// If [vertical] is true, then [top] and [bottom] can overflow.
  /// If [horizontal] is true, then [left] and [right] can overflow.
  ///
  /// Example:
  ///
  const OverflowRules.symmetric({
    bool vertical = false,
    bool horizontal = false,
  })  : left = horizontal,
        top = vertical,
        right = horizontal,
        bottom = vertical;

  /// Specifies that only certain edges can overflow.
  ///
  /// If an edge is set to true, then it can overflow.
  /// If an edge is set to false, then it cannot overflow.
  ///
  /// Example:
  ///
  const OverflowRules.only({
    this.left = false,
    this.top = false,
    this.right = false,
    this.bottom = false,
  });

  /// Whether the left edge can overflow.
  final bool left;
  /// Whether the top edge can overflow.
  final bool top;
  /// Whether the right edge can overflow.
  final bool right;
  /// Whether the bottom edge can overflow.
  final bool bottom;

  /// Whether any edge can overflow.
  bool get allowsOverflow {
    return left || top || right || bottom;
  }
}
