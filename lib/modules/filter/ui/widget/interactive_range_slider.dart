
import '../../../../utils/exports.dart';

/// A stateful widget that displays an interactive range slider.
///
/// This widget allows users to select a range of values between a minimum and
/// maximum, with visual feedback of the selected range and the ability to
/// dynamically update the selected values.
class InteractiveRangeSlider extends StatefulWidget {
  /// Creates a [InteractiveRangeSlider].
  const InteractiveRangeSlider({
    super.key,
    this.minValue,
    this.maxValue,
  });

  /// Minimum value for the slider (from backend)
  final double? minValue;

  /// Maximum value for the slider (from backend)
  final double? maxValue;

  @override
  InteractiveRangeSliderState createState() => InteractiveRangeSliderState();
}

/// The state for [InteractiveRangeSlider].
///
/// Manages the current range values and updates the UI when they change.

class InteractiveRangeSliderState extends State<InteractiveRangeSlider> {
  late RangeValues _rangeValues;

  @override
  void initState() {
    super.initState();
    _initializeRangeValues();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if we have saved price range from previous session
    _restoreSavedRangeIfNeeded();
  }

  @override
  void didUpdateWidget(InteractiveRangeSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update range values if backend values change
    if (oldWidget.minValue != widget.minValue || oldWidget.maxValue != widget.maxValue) {
      _initializeRangeValues();
    }
  }

  void _initializeRangeValues() {
    // Initialize with backend values or fallback to AppConstant
    final double minVal = widget.minValue ?? AppConstant.minRange.toDouble();
    final double maxVal = widget.maxValue ?? AppConstant.maxRange.toDouble();
    _rangeValues = RangeValues(minVal, maxVal);
  }

  void _restoreSavedRangeIfNeeded() {
    // Check if there's a saved price range in the cubit state
    final FilterPageCubit cubit = context.read<FilterPageCubit>();
    final RangeValues? savedRange = cubit.state.selectedPriceRange;

    if (savedRange != null) {
      final double backendMin = widget.minValue ?? AppConstant.minRange.toDouble();
      final double backendMax = widget.maxValue ?? AppConstant.maxRange.toDouble();

      // Check if the saved range is different from backend defaults
      // If it's different, it's a user selection that should be preserved
      if (savedRange.start != backendMin || savedRange.end != backendMax) {
        // Ensure saved values are within current backend bounds
        final double clampedStart = savedRange.start.clamp(backendMin, backendMax);
        final double clampedEnd = savedRange.end.clamp(backendMin, backendMax);

        // Allow start to go to backend minimum, end can be minimum + 0.01 or higher
        final double finalStart = clampedStart;
        final double minEndValue = backendMin + 0.01; // Allow end to be just above minimum
        final double finalEnd = clampedEnd.clamp(minEndValue, backendMax);

        _rangeValues = RangeValues(finalStart, finalEnd);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterPageCubit, FilterPageState>(
      builder: (BuildContext context, FilterPageState state) {
        // Update local range values if cubit state has changed
        if (state.selectedPriceRange != null) {
          final double backendMin = widget.minValue ?? AppConstant.minRange.toDouble();
          final double backendMax = widget.maxValue ?? AppConstant.maxRange.toDouble();
          
          // Check if the cubit range is different from our current range
          if (state.selectedPriceRange!.start != _rangeValues.start || 
              state.selectedPriceRange!.end != _rangeValues.end) {
            // Update our local state to match cubit state
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _rangeValues = RangeValues(
                    state.selectedPriceRange!.start.clamp(backendMin, backendMax),
                    state.selectedPriceRange!.end.clamp(backendMin, backendMax),
                  );
                });
              }
            });
          }
        }

        final double minVal = widget.minValue ?? AppConstant.minRange.toDouble();
        final double maxVal = widget.maxValue ?? AppConstant.maxRange.toDouble();

        // Add buffer to slider range
        final double sliderMin = minVal + 0.01; // Slider min is backend min + 0.01
        final double sliderMax = (maxVal - 1.0).clamp(1.0, maxVal);  // Slider max is backend max - 1, but at least 1

        // Allow start to be backend minimum, end can be minimum + 0.01 or higher
        final double finalStart = _rangeValues.start;
        final double minEndValue = minVal + 0.01; // Allow end to be just above minimum
        final double finalEnd = _rangeValues.end.clamp(minEndValue, maxVal);

        // Adjust range values to work with buffered slider bounds
        final double adjustedStart = finalStart.clamp(sliderMin, sliderMax);
        final double adjustedEnd = finalEnd.clamp(sliderMin, sliderMax);
        final RangeValues safeRangeValues = RangeValues(adjustedStart, adjustedEnd);

    return Column(
      children: <Widget>[
        const SizedBox(
          height: Dimens.size29,
        ),
        Padding(
          padding: const EdgeInsets.only(left: Dimens.space6,right: Dimens.space8),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              valueIndicatorTextStyle: context.textTheme.titleMedium?.copyWith(
                color: Colors.black,
                height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                fontSize: Dimens.fontSize14,
              ),
              thumbColor: MainConfig.appColors.mainColor,
              overlayColor: MainConfig.appColors.mainColor,
              activeTrackColor: MainConfig.appColors.mainColor,
              trackHeight: Dimens.size5,
              inactiveTrackColor: MainConfig.appColors.dividerGreyColor,
              rangeThumbShape: CustomRangeThumbShape(),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
            ),
            child: RangeSlider(
              values: safeRangeValues,
              min: sliderMin,
              max: sliderMax,
              labels: RangeLabels(
                '${safeRangeValues.start.toStringAsFixed(2)} KD',
                '${safeRangeValues.end.toStringAsFixed(2)} KD',
              ),
              onChanged: (RangeValues values) {
                final double backendStart = values.start.clamp(minVal, maxVal);
                final double backendEnd = values.end.clamp(minVal, maxVal);
                // Ensure end is at least minimum + 0.01
                final double minEndValue = minVal + 0.01;
                final double finalEnd = backendEnd.clamp(minEndValue, maxVal);
                final RangeValues safeValues = RangeValues(backendStart, finalEnd);
                setState(() {
                  _rangeValues = safeValues; // Update values dynamically
                });
                context.read<FilterPageCubit>().updatePriceRange(
                  safeValues.start,
                  safeValues.end,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: Dimens.size25),
        Padding(
    padding: const EdgeInsets.only(
    left: Dimens.space14, right: Dimens.space16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: Dimens.space12, right: Dimens.space5, top: Dimens.space10, bottom: Dimens.space5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: Dimens.radius8.borderRadius ,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomTextLabelWidget(
                        label: context.appString.minInKDKey,
                        style: context.textTheme.titleMedium
                            ?.copyWith(
                            color: MainConfig.appColors.labelGrey,
                            fontWeight: FontWeight.normal,
                            fontSize: Dimens.fontSize12),
                      ),
              CustomTextLabelWidget(
                label: safeRangeValues.start.toStringAsFixed(2),
                style: context.textTheme.titleMedium
            ?.copyWith(
            color: AppColors.blackColor,
            fontWeight: FontWeight.normal,
            height: Dimens.lineHeight30
                .toLineHeight(Dimens.fontSize16),
            fontSize: Dimens.fontSize16),
              ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: Dimens.size13),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: Dimens.space12, right: Dimens.space5, top: Dimens.space10, bottom: Dimens.space5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: Dimens.radius8.borderRadius ,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        context.appString.maxInKDKey,
                        style: context.textTheme.titleMedium
                            ?.copyWith(
                            color: MainConfig.appColors.labelGrey,
                            fontWeight: FontWeight.normal,
                            fontSize: Dimens.fontSize12),
                      ),
                      CustomTextLabelWidget(
                        label: safeRangeValues.end.toStringAsFixed(2),
                        style: context.textTheme.titleMedium
                            ?.copyWith(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.normal,
                            height: Dimens.lineHeight30
                                .toLineHeight(Dimens.fontSize16),
                            fontSize: Dimens.fontSize16),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
      },
    );
  }
}

/// A custom shape for the range slider thumb.
///
/// This shape allows for a rounded rectangle thumb design, offering a more
/// visually appealing and distinct slider thumb compared to the default
/// circular shape.
/// Custom Range Slider Thumb Shape
class CustomRangeThumbShape extends RangeSliderThumbShape {
  /// Creates a [CustomRangeThumbShape].
  final double thumbRadius;
///
  CustomRangeThumbShape({this.thumbRadius = Dimens.radius12});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbRadius * 2, thumbRadius * 2);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = true,
    bool isOnTop = false,
    bool isPressed = false,
    required SliderThemeData sliderTheme,
    TextDirection textDirection = TextDirection.ltr,
     Thumb? thumb,
  }) {
    final Canvas canvas = context.canvas;

    final Paint paint = Paint()
      ..color =
           sliderTheme.thumbColor ?? MainConfig.appColors.mainColor
      ..style = PaintingStyle.fill;

    // Draw custom rounded rectangle thumb
    final Rect rect = Rect.fromCenter(
      center: center,
      width: thumbRadius * 2,
      height: thumbRadius * 2,
    );
    final Radius radius = Radius.circular(thumbRadius);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paint);
  }
}
