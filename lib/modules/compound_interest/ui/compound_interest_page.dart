import '../../../utils/exports.dart';

@RoutePage()
/// Page for calculating compound interest with monthly contribution projections.
class CompoundInterestPage extends BaseResponsiveView {
  const CompoundInterestPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<CompoundInterestCubit>(
      create: (BuildContext context) => CompoundInterestCubit(),
      child: const CompoundInterestViewBody(),
    );
  }
}

class CompoundInterestViewBody extends StatefulWidget {
  const CompoundInterestViewBody({super.key});

  @override
  State<CompoundInterestViewBody> createState() => _CompoundInterestViewBodyState();
}

class _CompoundInterestViewBodyState extends State<CompoundInterestViewBody> {




  void _showInfoDialog(BuildContext context) {
    unawaited(showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        backgroundColor: context.isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        title: CustomTextLabelWidget(
          label: 'About Compound Interest',
          style: TextStyle(
            color: context.isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: CustomTextLabelWidget(
          label: 'Compound interest is interest calculated on the initial principal, which also includes all of the accumulated interest from previous periods on a deposit or loan.',
          style: TextStyle(
            color: context.isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
          textAlign: TextAlign.start,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const CustomTextLabelWidget(
              label: 'Close',
              style: TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ));
  }

  String _getCurrencySymbol(String currencyCode) {
    switch (currencyCode) {
      case 'EUR':
        return '€';
      case 'INR':
        return '₹';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'AUD':
        return r'A$';
      case 'CAD':
        return r'C$';
      case 'USD':
      default:
        return r'$';
    }
  }

  String _formatCurrency(double val, String currencyCode) {
    final NumberFormat formatter = NumberFormat('#,##0.00', 'en_US');
    final String symbol = _getCurrencySymbol(currencyCode);
    return '$symbol${formatter.format(val)}';
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderCol = isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color headerBannerBg = isDark ? const Color(0xFF130E26) : const Color(0xFFF1EAFF);
    final Color inputBg = isDark ? const Color(0xFF1E1736) : Colors.black.withValues(alpha: 0.03);

    return BlocBuilder<CompoundInterestCubit, CompoundInterestState>(
      builder: (BuildContext context, CompoundInterestState state) {
        final String curSymbol = _getCurrencySymbol(state.selectedCurrency);
        return Scaffold(
          backgroundColor: pageBg,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.space16,
                    vertical: Dimens.space12,
                  ),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => context.router.back(),
                        child: Container(
                          padding: const EdgeInsets.all(Dimens.space8),
                          decoration: BoxDecoration(
                            color: cardBg,
                            shape: BoxShape.circle,
                            border: Border.all(color: borderCol),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: textColor,
                            size: Dimens.size16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          child: CustomTextLabelWidget(
                            label: 'Compound Interest',
                            style: TextStyle(
                              fontSize: Dimens.fontSize18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showInfoDialog(context),
                        child: Container(
                          padding: const EdgeInsets.all(Dimens.space8),
                          decoration: BoxDecoration(
                            color: cardBg,
                            shape: BoxShape.circle,
                            border: Border.all(color: borderCol),
                          ),
                          child: Icon(
                            Icons.info_outline_rounded,
                            color: textColor,
                            size: Dimens.size16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: Dimens.space8),
                        // Header Banner
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: headerBannerBg,
                            borderRadius: BorderRadius.circular(Dimens.radius16),
                            border: Border.all(color: borderCol),
                          ),
                          padding: const EdgeInsets.all(Dimens.space16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    CustomTextLabelWidget(
                                      label: 'Estimate the future value of your investments',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: Dimens.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: Dimens.space8),
                              // Illustrative bar chart graphic for Compound Interest header
                              SizedBox(
                                width: 100,
                                height: 80,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: Container(
                                        width: 16,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryPurple.withValues(alpha: 0.4),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 22,
                                      child: Container(
                                        width: 16,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryPurple.withValues(alpha: 0.6),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 44,
                                      child: Container(
                                        width: 16,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryPurple.withValues(alpha: 0.8),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 66,
                                      child: Container(
                                        width: 16,
                                        height: 75,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryPurple,
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      left: 10,
                                      child: Icon(
                                        Icons.trending_up_rounded,
                                        color: isDark ? Colors.white : AppColors.primaryPurple,
                                        size: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimens.space24),

                        // Currency Selector Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomTextLabelWidget(
                              label: 'Currency',
                              style: TextStyle(
                                color: subtextColor,
                                fontSize: Dimens.fontSize14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: Dimens.space12),
                              decoration: BoxDecoration(
                                color: inputBg,
                                borderRadius: BorderRadius.circular(Dimens.radius8),
                                border: Border.all(color: borderCol),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: state.selectedCurrency,
                                  dropdownColor: cardBg,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: subtextColor,
                                  ),
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: Dimens.fontSize14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      context.read<CompoundInterestCubit>().updateCurrency(newValue);
                                    }
                                  },
                                  items: <String>['USD', 'EUR', 'INR', 'GBP', 'JPY', 'AUD', 'CAD']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    final String symbol = _getCurrencySymbol(value);
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: CustomTextLabelWidget(
                                        label: '$value ($symbol)',
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: Dimens.fontSize14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimens.space20),

                        // Principal Amount Slider
                        SliderInputRowWidget(
                          label: 'Principal Amount',
                          value: state.initialInvestment,
                          min: 1000.0,
                          max: 10000000.0,
                          isCurrency: true,
                          currencySymbol: curSymbol,
                          onChanged: (double val) {
                            context.read<CompoundInterestCubit>().updateInitialInvestment(val);
                          },
                        ),
                        const SizedBox(height: Dimens.space20),

                        // Rate of Interest (%) Slider
                        SliderInputRowWidget(
                          label: 'Rate of Interest (%)',
                          value: state.annualInterestRate,
                          min: 1.0,
                          max: 30.0,
                          suffix: '%',
                          onChanged: (double val) {
                            context.read<CompoundInterestCubit>().updateAnnualInterestRate(val);
                          },
                        ),
                        const SizedBox(height: Dimens.space20),

                        // Time Period (Years) Slider
                        SliderInputRowWidget(
                          label: 'Time Period (Years)',
                          value: state.years.toDouble(),
                          min: 1.0,
                          max: 40.0,
                          suffix: ' Yr',
                          onChanged: (double val) {
                            context.read<CompoundInterestCubit>().updateYears(val.toInt());
                          },
                        ),
                        const SizedBox(height: Dimens.space20),

                        // Compounding Frequency Selector
                        CompoundInterestFrequencySwitcher(
                          activeFrequency: state.compoundFrequency,
                          onFrequencyChanged: (String freq) {
                            context.read<CompoundInterestCubit>().updateCompoundFrequency(freq);
                          },
                        ),
                        const SizedBox(height: Dimens.space24),

                        // Results Card
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF0F0B22) : Colors.white,
                            borderRadius: BorderRadius.circular(Dimens.radius16),
                            border: Border.all(
                              color: isDark ? AppColors.borderDark : AppColors.borderLight,
                            ),
                          ),
                          padding: const EdgeInsets.all(Dimens.space16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CompoundInterestDetailRowWidget(
                                label: 'Principal Amount',
                                value: _formatCurrency(state.initialInvestment, state.selectedCurrency),
                                textColor: textColor,
                                bulletColor: isDark ? Colors.white24 : Colors.grey.shade300,
                              ),
                              const SizedBox(height: Dimens.space12),
                              CompoundInterestDetailRowWidget(
                                label: 'Total Interest',
                                value: _formatCurrency(state.interestEarned, state.selectedCurrency),
                                textColor: textColor,
                                bulletColor: AppColors.primaryPurple,
                              ),
                              const SizedBox(height: Dimens.space16),
                              const Divider(color: AppColors.borderDark, height: 1),
                              const SizedBox(height: Dimens.space16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: CustomTextLabelWidget(
                                      label: 'Amount in ${state.years} Yr',
                                      style: TextStyle(
                                        color: subtextColor,
                                        fontSize: Dimens.fontSize14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  const SizedBox(width: Dimens.space8),
                                  Flexible(
                                    child: CustomTextLabelWidget(
                                      label: _formatCurrency(state.futureValue, state.selectedCurrency),
                                      style: const TextStyle(
                                        color: AppColors.primaryPurple,
                                        fontSize: Dimens.fontSize20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimens.space20),
                              CompoundInterestBreakdownBar(
                                principal: state.initialInvestment,
                                interest: state.interestEarned,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimens.space24),

                        // Growth Over Time Chart Card
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF0F0B22) : Colors.white,
                            borderRadius: BorderRadius.circular(Dimens.radius16),
                            border: Border.all(
                              color: isDark ? AppColors.borderDark : AppColors.borderLight,
                            ),
                          ),
                          padding: const EdgeInsets.all(Dimens.space16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomTextLabelWidget(
                                label: 'Growth Over Time',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: Dimens.fontSize15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: Dimens.space20),
                              SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: CustomPaint(
                                  painter: ChartPainter(
                                    data: state.yearlyGrowth,
                                    years: state.years,
                                    isDark: isDark,
                                    currencySymbol: curSymbol,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimens.space32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CompoundInterestDetailRowWidget extends StatelessWidget {
  final String label;
  final String value;
  final Color textColor;
  final Color bulletColor;

  const CompoundInterestDetailRowWidget({
    super.key,
    required this.label,
    required this.value,
    required this.textColor,
    required this.bulletColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bulletColor,
          ),
        ),
        const SizedBox(width: Dimens.space10),
        Expanded(
          child: CustomTextLabelWidget(
            label: label,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.7),
              fontSize: Dimens.fontSize13,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(width: Dimens.space8),
        Flexible(
          child: CustomTextLabelWidget(
            label: value,
            style: TextStyle(
              color: bulletColor,
              fontSize: Dimens.fontSize13,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class ChartPainter extends CustomPainter {
  ChartPainter({
    required this.data,
    required this.years,
    required this.isDark,
    required this.currencySymbol,
  });

  final List<double> data;
  final int years;
  final bool isDark;
  final String currencySymbol;

  @override
  void paint(Canvas canvas, Size size) {
    const double leftPadding = 50.0;
    const double bottomPadding = 30.0;
    const double topPadding = 20.0;
    const double rightPadding = 20.0;

    final double chartWidth = size.width - leftPadding - rightPadding;
    final double chartHeight = size.height - topPadding - bottomPadding;

    if (data.isEmpty) return;

    final double maxVal = data.last;
    final double range = maxVal > 0 ? maxVal : 1.0;

    // Grid lines Paint
    final Paint gridPaint = Paint()
      ..color = isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.right,
    );

    // Draw Y grid and labels
    for (int i = 0; i <= 4; i++) {
      final double fraction = i / 4.0;
      final double yVal = maxVal * fraction;
      final double yPos = topPadding + chartHeight * (1.0 - fraction);

      canvas.drawLine(
        Offset(leftPadding, yPos),
        Offset(leftPadding + chartWidth, yPos),
        gridPaint,
      );

      textPainter..text = TextSpan(
        text: _formatYAxisLabel(yVal),
        style: TextStyle(
          color: isDark ? Colors.white60 : Colors.black54,
          fontSize: 10,
          fontFamily: 'inter',
        ),
      )
      ..layout()
      ..paint(
        canvas,
        Offset(leftPadding - textPainter.width - 8.0, yPos - textPainter.height / 2),
      );
    }

    // Draw X grid/labels (0%, 25%, 50%, 75%, 100%)
    final double stepX = chartWidth / (data.length - 1);
    final List<double> xLabelFractions = <double>[0.0, 0.25, 0.50, 0.75, 1.0];
    for (final double frac in xLabelFractions) {
      final double yearVal = years * frac;
      final double xPos = leftPadding + chartWidth * frac;

      final String label = frac == 0.0 ? '0' : '${yearVal.toStringAsFixed(1)} Y';

      textPainter..text = TextSpan(
        text: label,
        style: TextStyle(
          color: isDark ? Colors.white60 : Colors.black54,
          fontSize: 10,
          fontFamily: 'inter',
        ),
      )
      ..layout()
      ..paint(
        canvas,
        Offset(xPos - textPainter.width / 2, size.height - bottomPadding + 6.0),
      );
    }

    // Generate Points
    final List<Offset> points = <Offset>[];
    for (int i = 0; i < data.length; i++) {
      final double x = leftPadding + i * stepX;
      final double fraction = data[i] / range;
      final double y = topPadding + chartHeight * (1.0 - fraction);
      points.add(Offset(x, y));
    }

    // Draw Fill Under Line
    if (points.isNotEmpty) {
      final Path fillPath = Path()
      ..moveTo(points.first.dx, topPadding + chartHeight);
      for (int i = 0; i < points.length; i++) {
        fillPath.lineTo(points[i].dx, points[i].dy);
      }
      fillPath..lineTo(points.last.dx, topPadding + chartHeight)
      ..close();

      final Paint fillPaint = Paint()
        ..shader = LinearGradient(
          colors: <Color>[
            AppColors.primaryPurple.withValues(alpha: isDark ? 0.35 : 0.2),
            AppColors.primaryPurple.withValues(alpha: 0.0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTRB(leftPadding, topPadding, leftPadding + chartWidth, topPadding + chartHeight));

      canvas.drawPath(fillPath, fillPaint);
    }

    // Draw Line
    final Paint linePaint = Paint()
      ..color = AppColors.primaryPurple
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Path linePath = Path();
    if (points.isNotEmpty) {
      linePath.moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length; i++) {
        linePath.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(linePath, linePaint);
    }

    // Draw Dot Markers
    final Paint dotPaint = Paint()
      ..color = AppColors.primaryPurple
      ..style = PaintingStyle.fill;
    final Paint dotBorderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      final double fraction = i / (points.length - 1);
      if (fraction == 0.0 || fraction == 0.25 || fraction == 0.50 || fraction == 0.75 || fraction == 1.0) {
        canvas..drawCircle(points[i], 5.0, dotBorderPaint)
        ..drawCircle(points[i], 3.0, dotPaint);
      }
    }

    // Draw Tooltip on the last point
    if (points.isNotEmpty) {
      final Offset lastPoint = points.last;
      final String tooltipText = '$currencySymbol${_formatTooltipAmount(maxVal)}\nat $years Years';

      final TextPainter tooltipPainter = TextPainter(
        text: TextSpan(
          text: tooltipText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            fontFamily: 'inter',
            height: 1.2,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )
      ..layout();

      final double rectW = tooltipPainter.width + 16.0;
      final double rectH = tooltipPainter.height + 12.0;

      final double rectX = lastPoint.dx - rectW - 10.0;
      final double rectY = lastPoint.dy - rectH / 2;

      final RRect tooltipRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(rectX, rectY, rectW, rectH),
        const Radius.circular(8.0),
      );

      final Paint tooltipBgPaint = Paint()
        ..color = const Color(0xFF130E26)
        ..style = PaintingStyle.fill;
      final Paint tooltipBorderPaint = Paint()
        ..color = AppColors.primaryPurple.withValues(alpha: 0.5)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;

      canvas..drawRRect(tooltipRRect, tooltipBgPaint)
      ..drawRRect(tooltipRRect, tooltipBorderPaint);

      tooltipPainter.paint(
        canvas,
        Offset(rectX + 8.0, rectY + 6.0),
      );
    }
  }

  String _formatYAxisLabel(double val) {
    if (val >= 1000000) {
      return '$currencySymbol${(val / 1000000.0).toStringAsFixed(1)}M';
    } else if (val >= 1000) {
      return '$currencySymbol${(val / 1000.0).toStringAsFixed(0)}K';
    } else {
      return '$currencySymbol${val.toStringAsFixed(0)}';
    }
  }

  String _formatTooltipAmount(double val) {
    final NumberFormat formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(val);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SliderInputRowWidget extends StatefulWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final String suffix;
  final bool isCurrency;
  final String currencySymbol;
  final ValueChanged<double> onChanged;

  const SliderInputRowWidget({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.suffix = '',
    this.isCurrency = false,
    this.currencySymbol = r'$',
  });

  @override
  State<SliderInputRowWidget> createState() => _SliderInputRowWidgetState();
}

class _SliderInputRowWidgetState extends State<SliderInputRowWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _formatValue(widget.value));
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(SliderInputRowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((oldWidget.value != widget.value || oldWidget.currencySymbol != widget.currencySymbol) && !_focusNode.hasFocus) {
      _controller.text = _formatValue(widget.value);
    }
  }

  @override
  void dispose() {
    _focusNode..removeListener(_onFocusChange)
    ..dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      final double? parsed = _parseText(_controller.text);
      if (parsed != null) {
        final double clamped = parsed.clamp(widget.min, widget.max);
        widget.onChanged(clamped);
        _controller.text = _formatValue(clamped);
      } else {
        _controller.text = _formatValue(widget.value);
      }
    }
  }

  String _formatValue(double val) {
    if (widget.isCurrency) {
      final NumberFormat formatter = NumberFormat('#,##0', 'en_US');
      return '${widget.currencySymbol}${formatter.format(val)}';
    } else {
      return '${val.toStringAsFixed(widget.suffix == '%' ? 1 : 0)}${widget.suffix}';
    }
  }

  double? _parseText(String text) {
    final String cleanText = text.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleanText);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color inputBg = isDark ? const Color(0xFF1E1736) : Colors.black.withValues(alpha: 0.03);
    final Color borderCol = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomTextLabelWidget(
              label: widget.label,
              style: TextStyle(
                color: subtextColor,
                fontSize: Dimens.fontSize14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              width: 120,
              height: 38,
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: inputBg,
                borderRadius: BorderRadius.circular(Dimens.radius8),
                border: Border.all(color: borderCol),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: textColor,
                  fontSize: Dimens.fontSize14,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                onSubmitted: (String val) {
                  _focusNode.unfocus();
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.space8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.primaryPurple,
            inactiveTrackColor: isDark ? Colors.white12 : Colors.black12,
            thumbColor: Colors.white,
            overlayColor: AppColors.primaryPurple.withValues(alpha: 0.12),
            valueIndicatorColor: AppColors.primaryPurple,
            trackHeight: 4.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
          ),
          child: Slider(
            value: widget.value.clamp(widget.min, widget.max),
            min: widget.min,
            max: widget.max,
            onChanged: (double val) {
              widget.onChanged(val);
              setState(() {
                _controller.text = _formatValue(val);
              });
            },
          ),
        ),
      ],
    );
  }
}

class CompoundInterestBreakdownBar extends StatelessWidget {
  final double principal;
  final double interest;

  const CompoundInterestBreakdownBar({
    super.key,
    required this.principal,
    required this.interest,
  });

  @override
  Widget build(BuildContext context) {
    final double total = principal + interest;
    if (total == 0) return const SizedBox.shrink();

    final double principalRatio = principal / total;
    final double interestRatio = interest / total;

    final bool isDark = context.isDark;
    final Color principalColor = isDark ? Colors.white24 : Colors.grey.shade300;
    final Color interestColor = AppColors.primaryPurple;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.radius6),
          child: SizedBox(
            height: 12,
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: (principalRatio * 1000).toInt(),
                  child: Container(
                    color: principalColor,
                  ),
                ),
                Flexible(
                  flex: (interestRatio * 1000).toInt(),
                  child: Container(
                    color: interestColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Dimens.space12),
        Row(
          children: <Widget>[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: principalColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: Dimens.space6),
            CustomTextLabelWidget(
              label: 'Principal',
              style: TextStyle(
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                fontSize: Dimens.fontSize12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: Dimens.space24),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: interestColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: Dimens.space6),
            CustomTextLabelWidget(
              label: 'Interest',
              style: TextStyle(
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                fontSize: Dimens.fontSize12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CompoundInterestFrequencySwitcher extends StatelessWidget {
  final String activeFrequency;
  final ValueChanged<String> onFrequencyChanged;

  const CompoundInterestFrequencySwitcher({
    super.key,
    required this.activeFrequency,
    required this.onFrequencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color activeColor = AppColors.primaryPurple;
    final Color inactiveBgColor = isDark ? const Color(0xFF1E1736) : Colors.black.withValues(alpha: 0.05);
    final Color activeTextColor = Colors.white;
    final Color inactiveTextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    final List<Map<String, String>> frequencies = <Map<String, String>>[
      <String, String>{'state': 'Annually', 'ui': 'Yearly'},
      <String, String>{'state': 'Semi-Annually', 'ui': 'Half Yearly'},
      <String, String>{'state': 'Quarterly', 'ui': 'Quarterly'},
      <String, String>{'state': 'Monthly', 'ui': 'Monthly'},
    ];

    final int activeIndex = frequencies.indexWhere((Map<String, String> f) => f['state'] == activeFrequency);
    final double alignX = frequencies.length > 1
        ? -1.0 + (activeIndex / (frequencies.length - 1)) * 2.0
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTextLabelWidget(
          label: 'Compounding Frequency',
          style: TextStyle(
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            fontSize: Dimens.fontSize13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: Dimens.space12),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: inactiveBgColor,
            borderRadius: BorderRadius.circular(Dimens.radius12),
          ),
          child: SizedBox(
            height: 40,
            child: Stack(
              children: <Widget>[
                AnimatedAlign(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  alignment: Alignment(alignX, 0.0),
                  child: FractionallySizedBox(
                    widthFactor: 1.0 / frequencies.length,
                    child: Container(
                      decoration: BoxDecoration(
                        color: activeColor,
                        borderRadius: BorderRadius.circular(Dimens.radius8),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: frequencies.map((Map<String, String> freq) {
                    final String stateName = freq['state']!;
                    final String uiName = freq['ui']!;
                    final bool isActive = stateName == activeFrequency;

                    return Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => onFrequencyChanged(stateName),
                        child: Center(
                          child: Text(
                            uiName,
                            style: TextStyle(
                              color: isActive ? activeTextColor : inactiveTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimens.fontSize12,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

