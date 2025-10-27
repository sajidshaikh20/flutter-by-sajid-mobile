import 'dart:ui';

import '../../../../utils/exports.dart';


/// colorFulSafeArea widget is for apply color for safe area.
///
/// This widget wraps a child widget and applies a colored background to the
/// safe area of the device screen. It allows customization of the color,
/// overflow behavior, tappability of the overflow area, and the minimum
/// padding.
///
/// The safe area is the portion of the screen that is not obstructed by system
/// UI elements, such as the status bar or the notch.
///
/// The [ColorfulSafeArea] can be configured to allow or disallow content to
/// overflow into the safe area using the [overflowRules] property.
///
/// It's possible to make the overflow area tappable using the [overflowTappable]
/// property.
///
/// The minimum padding can be specified with the [minimum] property.
///
/// The bottom view padding can be maintained using [maintainBottomViewPadding]
/// property
class ColorfulSafeArea extends StatelessWidget {

  ///ColorfulSafeArea constructor
  const ColorfulSafeArea({
    super.key,
    this.color = Colors.transparent,
    this.overflowRules = const OverflowRules.all(value:false),
    this.overflowTappable = false,
    this.bottom = true,
    this.left = true,
    this.top = true,
    this.right = true,
    this.minimum = EdgeInsets.zero,
    this.maintainBottomViewPadding = false,
    this.filter,
    required this.child,
  });

  /// The color to apply to the safe area.
  ///
  /// Defaults to [Colors.transparent].
  final Color color;

  /// Rules for determining which sides can overflow into the safe area.
  ///
  /// Defaults to allowing no overflow ([OverflowRules.all(value: false)]).
  final OverflowRules overflowRules;

  /// Whether the overflow area should be tappable.
  ///
  /// Defaults to `false`.
  final bool overflowTappable;

  /// Whether to apply the safe area to the left side.
  final bool left;

  /// Whether to apply the safe area to the top side.
  final bool top;

  /// Whether to apply the safe area to the right side.
  final bool right;

  /// Whether to apply the safe area to the bottom side.
  final bool bottom;

  /// The minimum padding to apply to the safe area.
  ///
  /// Defaults to [EdgeInsets.zero].
  final EdgeInsets minimum;

  /// Whether to maintain the bottom view padding.
  ///
  /// Defaults to `false`.
  final bool maintainBottomViewPadding;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// The image filter to apply to the safe area.
  ///
  /// If null, no filter is applied.
  ///
  /// Defaults to `null`.
  final ImageFilter? filter;

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    EdgeInsets padding = _createAdjustedPadding(data);
    EdgeInsets adjustedMinimum = _createAdjustedMinimum();

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (kDebugMode) {
          print("Hello from layout builder");
        }
        return Stack(
          children: <Widget>[
            SafeArea(
              left: !overflowRules.left && left,
              top: !overflowRules.top && top,
              right: !overflowRules.right && right,
              bottom: !overflowRules.bottom && bottom,
              minimum: adjustedMinimum,
              maintainBottomViewPadding: maintainBottomViewPadding,
              child: child,
            ),
            _TopAndBottom(
              color: color,
              padding: padding,
              overflowTappable: overflowTappable,
              constraints: constraints,
              filter: filter,
            ),
            _LeftAndRight(
              color: color,
              padding: padding,
              overflowTappable: overflowTappable,
              constraints: constraints,
              filter: filter,
            ),
          ],
        );
      },
    );
  }

  // calculates the padding required
  EdgeInsets _createAdjustedPadding(MediaQueryData data) {
    return EdgeInsets.only(
      left: left ? max(data.padding.left, minimum.left) : minimum.left,
      top: top ? max(data.padding.top, minimum.top) : minimum.top,
      right: right ? max(data.padding.right, minimum.right) : minimum.right,
      bottom:
          bottom ? max(data.padding.bottom, minimum.bottom) : minimum.bottom,
    );
  }

  // ignores the minimum for a side if it is allowed to overflow
  EdgeInsets _createAdjustedMinimum() {
    return minimum.copyWith(
      left: overflowRules.left ? 0 : minimum.left,
      top: overflowRules.top ? 0 : minimum.top,
      right: overflowRules.right ? 0 : minimum.right,
      bottom: overflowRules.bottom ? 0 : minimum.bottom,
    );
  }
}

class _TopAndBottom extends StatelessWidget {
  const _TopAndBottom({
    required this.color,
    required this.padding,
    required this.overflowTappable,
    required this.constraints,
    this.filter,
  });

  final Color color;
  final EdgeInsets padding;
  final bool overflowTappable;
  final BoxConstraints constraints;
  final ImageFilter? filter;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: overflowTappable,
      child: Column(
        children: <Widget>[
          (filter != null)
              ? ClipRect(
                  child: BackdropFilter(
                    filter: filter!,
                    child: Container(
                      height: padding.top,
                      width: constraints.maxWidth,
                      color: color,
                    ),
                  ),
                )
              : Container(
                  height: padding.top,
                  width: constraints.maxWidth,
                  color: color,
                ),
          const Spacer(),
          (filter != null)
              ? ClipRect(
                  child: BackdropFilter(
                    filter: filter!,
                    child: Container(
                      height: padding.bottom,
                      width: constraints.maxWidth,
                      color: MainConfig.appColors.transparent,
                    ),
                  ),
                )
              : Container(
                  height: padding.bottom,
                  width: constraints.maxWidth,
                  color: MainConfig.appColors.transparent,
                ),
        ],
      ),
    );
  }
}

class _LeftAndRight extends StatelessWidget {
  const _LeftAndRight({
    required this.color,
    required this.padding,
    required this.overflowTappable,
    required this.constraints,
    this.filter,
  });

  final Color color;
  final EdgeInsets padding;
  final bool overflowTappable;
  final BoxConstraints constraints;
  final ImageFilter? filter;

  double get _sideHeight =>
      constraints.maxHeight - padding.top - padding.bottom;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: overflowTappable,
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: padding.top,
              ),
              (filter != null)
                  ? ClipRect(
                      child: BackdropFilter(
                        filter: filter!,
                        child: Container(
                          width: padding.left,
                          height: _sideHeight,
                          color: color,
                        ),
                      ),
                    )
                  : Container(
                      width: padding.left,
                      height: _sideHeight,
                      color: color,
                    ),
            ],
          ),
          const Spacer(),
          Column(
            children: <Widget>[
              SizedBox(
                height: padding.top,
              ),
              (filter != null)
                  ? ClipRect(
                      child: BackdropFilter(
                        filter: filter!,
                        child: Container(
                          width: padding.right,
                          height: _sideHeight,
                          color: color,
                        ),
                      ),
                    )
                  : Container(
                      width: padding.right,
                      height: _sideHeight,
                      color: color,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
